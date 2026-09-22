variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Map of public subnet names to subnet IDs"
  type        = map(string)
}

variable "app_subnet_ids" {
  description = "Map of application subnet names to subnet IDs"
  type        = map(string)
}

variable "db_subnet_ids" {
  description = "Map of database subnet names to subnet IDs"
  type        = map(string)
}