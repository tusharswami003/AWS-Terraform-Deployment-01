aws_region   = "ap-south-1"
environment  = "test"
project_name = "terraform-eks"

vpc_cidr = "10.20.0.0/16"


subnets = {
  public-a = {
    cidr_block        = "10.20.1.0/24"
    availability_zone = "ap-south-1a"
    tier              = "public"

    tags = {
      "kubernetes.io/role/elb" = "1"
    }
  }

  public-b = {
    cidr_block        = "10.20.2.0/24"
    availability_zone = "ap-south-1b"
    tier              = "public"

    tags = {
      "kubernetes.io/role/elb" = "1"
    }
  }

  private-a = {
    cidr_block        = "10.20.11.0/24"
    availability_zone = "ap-south-1a"
    tier              = "app"

    tags = {
      "kubernetes.io/role/internal-elb" = "1"
    }
  }

  private-b = {
    cidr_block        = "10.20.12.0/24"
    availability_zone = "ap-south-1b"
    tier              = "app"

    tags = {
      "kubernetes.io/role/internal-elb" = "1"
    }
  }
}

eks_cluster_name   = "test-eks-cluster"
kubernetes_version = "1.36"

eks_admin_principal_arn = "arn:aws:iam::190944421381:root"

eks_node_group_name = "test-eks-node-group-v2"

eks_instance_types = [
  "t3.medium"
]

eks_capacity_type = "ON_DEMAND"

eks_desired_size = 2
eks_min_size     = 2
eks_max_size     = 3