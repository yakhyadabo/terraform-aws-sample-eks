locals {
  cluster_name = format("%s-%s", var.project.name, var.project.environment)
  vpc_name = format("%s-vpc",var.project.environment)
  cluster_sg_name = format("%s-%s",local.cluster_name,"cluster-sg")
  node_sg_name = format("%s-%s",local.cluster_name,"node-group-sg")
}

module "eks" {
  source               = "../module"
  region               = var.region
  cluster_name         = local.cluster_name
  project_name         = var.project.name
  vpc_name             = local.vpc_name
  key_name             = var.key_name
  cluster_sg_name      = local.cluster_name
  nodes_sg_name        = local.node_sg_name
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
}