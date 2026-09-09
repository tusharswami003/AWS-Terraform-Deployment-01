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

output "ec2_instance_id" {
  description = "ID of the dev EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "Private IP address of the dev EC2 instance"
  value       = module.ec2.private_ip
}