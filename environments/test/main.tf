module "vpc" {
  source = "../../modules/vpc"

  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets
}

module "nat" {
  source = "../../modules/nat"

  environment      = var.environment
  public_subnet_id = module.subnet.subnet_ids["public-a"]

}

module "routing" {
  source = "../../modules/routing"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id      = module.nat.nat_gateway_id

  public_subnet_ids = {
    for name, id in module.subnet.subnet_ids :
    name => id
    if var.subnets[name].tier == "public"
  }

  app_subnet_ids = {
    for name, id in module.subnet.subnet_ids :
    name => id
    if var.subnets[name].tier == "app"
  }

  db_subnet_ids = {
    for name, id in module.subnet.subnet_ids :
    name => id
    if var.subnets[name].tier == "db"
  }
}

module "eks_cluster_role" {
  source = "../../modules/iam"

  role_name = "${var.environment}-eks-cluster-role"

  service_principals = [
    "eks.amazonaws.com"
  ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]
}

module "eks_node_role" {
  source = "../../modules/iam"

  role_name = "${var.environment}-eks-node-role"

  service_principals = [
    "ec2.amazonaws.com"
  ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.eks_cluster_name
  kubernetes_version = var.kubernetes_version

  cluster_role_arn = module.eks_cluster_role.role_arn

  subnet_ids = [
    module.subnet.subnet_ids["private-a"],
    module.subnet.subnet_ids["private-b"]
  ]

  admin_principal_arn = var.eks_admin_principal_arn

  depends_on = [
    module.eks_cluster_role,
    module.routing
  ]
}

module "eks_node_group" {
  source = "../../modules/eks-node-group"

  cluster_name    = module.eks.cluster_name
  node_group_name = var.eks_node_group_name

  node_role_arn = module.eks_node_role.role_arn

  subnet_ids = [
    module.subnet.subnet_ids["private-a"],
    module.subnet.subnet_ids["private-b"]
  ]

  instance_types = var.eks_instance_types
  capacity_type  = var.eks_capacity_type

  desired_size = var.eks_desired_size
  min_size     = var.eks_min_size
  max_size     = var.eks_max_size

  depends_on = [
    module.eks,
    module.eks_node_role,
    module.routing,
    module.nat
  ]
}