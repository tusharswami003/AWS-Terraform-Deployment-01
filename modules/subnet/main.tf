resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    {
      Name        = "${var.environment}-${each.key}"
      Environment = var.environment
      Tier        = each.value.tier
    },

    each.value.tier == "public" ? {
      "kubernetes.io/role/elb" = "1"
    } : {},

    each.value.tier == "app" ? {
      "kubernetes.io/role/internal-elb" = "1"
    } : {}
  )
}