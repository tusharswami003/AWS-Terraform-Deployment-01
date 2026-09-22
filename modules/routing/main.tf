resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "dev-igw"
  }
}

# route table and it's association for public subnets
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# route table and it's association for app subnets
resource "aws_route_table" "app" {
  vpc_id = var.vpc_id

  tags = {
    Name = "dev-app-rt"
  }
}

resource "aws_route_table_association" "app" {
  for_each = var.app_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.app.id
}


# route table and it's association for db subnets
resource "aws_route_table" "db" {
  vpc_id = var.vpc_id

  tags = {
    Name = "dev-db-rt"
  }
}

resource "aws_route_table_association" "db" {
  for_each = var.db_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.db.id
}