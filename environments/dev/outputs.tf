output "vpc_id" {
  description = "ID of the dev VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "IDs of the dev subnets"
  value       = module.subnet.subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the dev Internet Gateway"
  value       = module.routing.internet_gateway_id
}

output "route_table_ids" {
  description = "Route table IDs for the dev environment"

  value = {
    public = module.routing.public_route_table_id
    app    = module.routing.app_route_table_id
    db     = module.routing.db_route_table_id
  }
}

output "security_group_id" {
  description = "ID of the dev EC2 security group"
  value       = module.security_group.security_group_id
}

output "alb_dns_name" {
  description = "DNS name of the dev Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the dev Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_target_group_arn" {
  description = "ARN of the dev ALB target group"
  value       = module.alb.target_group_arn
}

output "app_servers" {
  description = "Details of all dev APP EC2 instances"

  value = {
    for name, server in module.app-ec2 :
    name => {
      instance_id = server.instance_id
      private_ip  = server.private_ip
    }
  }
}

output "db_servers" {
  description = "Details of all dev DB EC2 instances"

  value = {
    for name, server in module.db-ec2 :
    name => {
      instance_id = server.instance_id
      private_ip  = server.private_ip
    }
  }
}