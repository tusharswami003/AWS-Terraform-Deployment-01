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

module "routing" {
  source = "../../modules/routing"

  vpc_id = module.vpc.vpc_id

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

module "security_group" {
  source = "../../modules/security-group"

  name        = "dev-ec2-sg"
  description = "Security group for dev EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = []
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

  target_instance_ids = {
    for name, server in module.app-ec2 :
    name => server.instance_id
  }

  target_port       = var.app_port
  health_check_path = var.health_check_path
}

module "app-ec2" {
  for_each = var.app_servers

  source = "../../modules/ec2"

  name               = each.key
  ami_id             = var.ec2_ami_id
  instance_type      = each.value.instance_type
  subnet_id          = module.subnet.subnet_ids[each.value.subnet_name]
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.ec2_key_name
}

module "db-ec2" {
  for_each = var.db_servers

  source = "../../modules/ec2"

  name               = each.key
  ami_id             = var.ec2_ami_id
  instance_type      = var.db_instance_type
  subnet_id          = module.subnet.subnet_ids[each.value.subnet_name]
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.ec2_key_name
}