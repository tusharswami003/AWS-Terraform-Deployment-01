output "vpc_id" {
  description = "ID of the dev VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "IDs of the dev subnets"
  value       = module.subnet.subnet_ids
}

output "security_group_id" {
  description = "ID of the dev EC2 security group"
  value       = module.security_group.security_group_id
}

output "ec2-00_instance_id" {
  description = "ID of the dev EC2 instance"
  value       = module.ec2_00.instance_id
}

output "ec2_00_private_ip" {
  description = "Private IP address of the dev EC2 instance"
  value       = module.ec2_00.private_ip
}

output "ec2_01_instance_id" {
  description = "ID of the dev EC2 instance"
  value       = module.ec2_01.instance_id
}

output "ec2_01_private_ip" {
  description = "Private IP address of the dev EC2 instance"
  value       = module.ec2_01.private_ip
}