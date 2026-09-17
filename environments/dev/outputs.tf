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

output "ec2_instance_ids" {
  description = "IDs of the application servers"

  value = {
    for name, server in module.ec2 :
    name => server.instance_id
  }
}

output "ec2_private_ips" {
  description = "Private IPs of the application servers"

  value = {
    for name, server in module.ec2 :
    name => server.private_ip
  }
}