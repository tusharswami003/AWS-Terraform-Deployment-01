aws_region = "ap-south-1"

vpc_cidr = "10.10.0.0/16"

subnets = {
  public-a = {
    cidr_block        = "10.10.1.0/24"
    availability_zone = "ap-south-1a"
    tier              = "public"
  }

  public-b = {
    cidr_block        = "10.10.2.0/24"
    availability_zone = "ap-south-1b"
    tier              = "public"
  }

  app-a = {
    cidr_block        = "10.10.11.0/24"
    availability_zone = "ap-south-1a"
    tier              = "app"
  }

  app-b = {
    cidr_block        = "10.10.12.0/24"
    availability_zone = "ap-south-1b"
    tier              = "app"
  }

  db-a = {
    cidr_block        = "10.10.21.0/24"
    availability_zone = "ap-south-1a"
    tier              = "db"
  }

  db-b = {
    cidr_block        = "10.10.22.0/24"
    availability_zone = "ap-south-1b"
    tier              = "db"
  }
}

ec2_ami_id   = "ami-01a00762f46d584a1"
ec2_key_name = null

app_servers = {
  dev-app-01 = {
    instance_type = "t3.micro"
    subnet_name   = "app-a"
  }

  dev-app-02 = {
    instance_type = "t3.small"
    subnet_name   = "app-b"
  }
}

app_port          = 80
health_check_path = "/"

db_instance_type = "t3.small"
db_port = 5432

db_servers = {
  dev-db-01 = {
    subnet_name = "db-a"
  }

  dev-db-02 = {
    subnet_name = "db-b"
  }
}