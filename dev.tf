module "eks" {
  source               = "./module"
  region               = var.region
  environment          = var.project.environment
  vpc_name             = "${var.project.environment}-vpc"
  service_name         = var.service_name
  key_name             = var.key_name
  cluster_sg_name      = "eks-cluster-sg"
  nodes_sg_name = "node-group-sg"
}