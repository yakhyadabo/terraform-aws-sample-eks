resource "aws_eks_cluster" "main" {
  name     = join("-", [var.service_name, var.environment])
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    security_group_ids      = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    // public_access_cidrs = ["0.0.0.0/0",]
    subnet_ids = flatten([data.aws_subnets.private.ids, data.aws_subnets.public.ids ])
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_cluster_policy
  ]

  tags = {
    Name = join("-", [var.service_name, var.environment])
  }
}