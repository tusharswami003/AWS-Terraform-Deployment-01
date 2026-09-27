aws_region   = "ap-south-1"
environment  = "test"
project_name = "terraform-eks"

vpc_cidr = "10.20.0.0/16"


subnets = {
  public-a = {
    cidr_block        = "10.20.1.0/24"
    availability_zone = "ap-south-1a"
    tier              = "public"
  }

  public-b = {
    cidr_block        = "10.20.2.0/24"
    availability_zone = "ap-south-1b"
    tier              = "public"
  }

  private-a = {
    cidr_block        = "10.20.11.0/24"
    availability_zone = "ap-south-1a"
    tier              = "app"
  }

  private-b = {
    cidr_block        = "10.20.12.0/24"
    availability_zone = "ap-south-1b"
    tier              = "app"
  }
}

eks_cluster_name   = "test-eks-cluster"
kubernetes_version = "1.36"

eks_node_group_name = "test-eks-node-group"

eks_instance_types = [
  "t3.micro"
]

eks_capacity_type = "ON_DEMAND"

eks_desired_size = 2
eks_min_size     = 2
eks_max_size     = 4