output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for name, subnet in aws_subnet.this : name => subnet.id }
}