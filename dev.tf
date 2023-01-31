locals {
  cluster_name = format("%s-%s", var.project.name, var.project.environment)
}

module "eks" {
  source               = "./module"
  region               = var.region
  cluster_name         = local.cluster_name
  project_name         = var.project.name
  vpc_name             = format("%s-vpc",var.project.environment)
  key_name             = var.key_name
  cluster_sg_name      = format("%s-%s",local.cluster_name,"cluster-sg")
  nodes_sg_name        = format("%s-%s",local.cluster_name,"node-group-sg")
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
}