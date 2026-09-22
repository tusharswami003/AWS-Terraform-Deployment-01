output "subnet_ids" {
  description = "Map of subnet names to their IDs"

  value = {
    for name, subnet in aws_subnet.this :
    name => subnet.id
  }
}

output "subnet_availability_zones" {
  description = "Map of subnet names to availability zones"

  value = {
    for name, subnet in aws_subnet.this :
    name => subnet.availability_zone
  }
}

output "subnet_details" {
  description = "Details of all created subnets"

  value = {
    for name, subnet in aws_subnet.this :
    name => {
      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
    }
  }
}