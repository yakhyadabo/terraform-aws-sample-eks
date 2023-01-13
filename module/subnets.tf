# VPC of the subnets
data "aws_vpc" "main" {
  tags = {
    Name = var.vpc_name
    Environment = var.environment
  }
}

# Subnets of the EKS cluster
data "aws_subnets" "eks_cluster" {
  filter {
    name   = local.vpc_id
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Tier = local.tier.eks_cluster
  }
}

# Private Subnets of the node groups
data "aws_subnets" "private" {
  filter {
    name   = local.vpc_id
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Tier = local.tier.private
  }
}

# Public Subnets of the node groups
data "aws_subnets" "public" {
  filter {
    name   = local.vpc_id
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Tier = local.tier.public
  }
}