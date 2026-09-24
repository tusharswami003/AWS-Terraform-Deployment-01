module "vpc" {
  source = "../../modules/vpc"

  environment = "dev"
  vpc_cidr    = var.vpc_cidr
}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets
}

module "nat" {
  source = "../../modules/nat"

  environment      = "dev"
  public_subnet_id = module.subnet.subnet_ids["public-a"]

}

module "routing" {
  source = "../../modules/routing"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id      = module.nat.nat_gateway_id

  public_subnet_ids = {
    for name, id in module.subnet.subnet_ids :
    name => id
    if var.subnets[name].tier == "public"
  }

  app_subnet_ids = {
    for name, id in module.subnet.subnet_ids :
    name => id
    if var.subnets[name].tier == "app"
  }

  db_subnet_ids = {
    for name, id in module.subnet.subnet_ids :
    name => id
    if var.subnets[name].tier == "db"
  }
}


module "alb_security_group" {
  source = "../../modules/security-group"

  name        = "dev-alb-sg"
  description = "Security group for the dev Application Load Balancer"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "Allow HTTP from internet"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "alb" {
  source = "../../modules/alb"

  name   = "dev-app-alb"
  vpc_id = module.vpc.vpc_id

  subnet_ids = [
    module.subnet.subnet_ids["public-a"],
    module.subnet.subnet_ids["public-b"]
  ]

  security_group_ids = [
    module.alb_security_group.security_group_id
  ]

  target_port       = var.app_port
  health_check_path = var.health_check_path
}

module "app_security_group" {
  source = "../../modules/security-group"

  name        = "dev-app-sg"
  description = "Security group for dev application servers"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "Allow application traffic from ALB"
      from_port   = var.app_port
      to_port     = var.app_port
      protocol    = "tcp"

      security_group_ids = [
        module.alb_security_group.security_group_id
      ]
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "db_security_group" {
  source = "../../modules/security-group"

  name        = "dev-db-sg"
  description = "Security group for dev database servers"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "Allow database traffic from application servers"
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = "tcp"

      security_group_ids = [
        module.app_security_group.security_group_id
      ]
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2_ssm" {
  source = "../../modules/ec2-ssm"
}

module "app_launch_template" {
  source = "../../modules/launch-template"

  name          = "dev-app"
  ami_id        = var.ec2_ami_id
  instance_type = var.app_instance_type

  security_group_ids = [
    module.app_security_group.security_group_id
  ]

  iam_instance_profile_name = module.ec2_ssm.instance_profile_name

  key_name = var.ec2_key_name
}

module "app_autoscaling" {
  source = "../../modules/autoscaling"

  name = "dev-app-asg"

  launch_template_id      = module.app_launch_template.launch_template_id
  launch_template_version = tostring(module.app_launch_template.latest_version)

  subnet_ids = [
    module.subnet.subnet_ids["app-a"],
    module.subnet.subnet_ids["app-b"]
  ]

  target_group_arns = [
    module.alb.target_group_arn
  ]

  min_size         = var.app_min_size
  desired_capacity = var.app_desired_capacity
  max_size         = var.app_max_size

  depends_on = [
    module.routing
  ]
}

module "db-ec2" {
  for_each = var.db_servers

  source = "../../modules/ec2"

  name               = each.key
  ami_id             = var.ec2_ami_id
  instance_type      = var.db_instance_type
  subnet_id          = module.subnet.subnet_ids[each.value.subnet_name]
  security_group_ids = [module.db_security_group.security_group_id]
  key_name           = var.ec2_key_name
}