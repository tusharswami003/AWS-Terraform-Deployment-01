output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "app_route_table_id" {
  description = "ID of the application route table"
  value       = aws_route_table.app.id
}

output "db_route_table_id" {
  description = "ID of the database route table"
  value       = aws_route_table.db.id
}