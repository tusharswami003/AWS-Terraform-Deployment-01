aws_region = "ap-south-1"

vpc_cidr = "10.10.0.0/16"

subnets = {
  private-a = "10.10.1.0/24"
  private-b = "10.10.2.0/24"
}

ec2_ami_id        = "ami-01a00762f46d584a1"
ec2_instance_type = "t3.micro"
ec2_key_name      = null