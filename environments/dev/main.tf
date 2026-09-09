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

module "ec2" {
  source = "../../modules/ec2"

  name               = "dev-ec2"
  ami_id             = var.ec2_ami_id
  instance_type      = var.ec2_instance_type
  subnet_id          = module.subnet.subnet_ids["private-a"]
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.ec2_key_name
}