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

output "app_servers" {
  description = "Details of all dev APP EC2 instances"

  value = {
    for name, server in module.ec2 :
    name => {
      instance_id = server.instance_id
      private_ip  = server.private_ip
    }
  }
}

output "db_servers" {
  description = "Details of all dev DB EC2 instances"
  
  value = {
    for name, server in module.ec2 :
    name => {
      instance_id = server.instance_id
      private_ip  = server.private_ip
    }
  }
}