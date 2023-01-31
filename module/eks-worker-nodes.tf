# Nodes in private subnets
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = format("%s-%s", var.cluster_name, "node-group")
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = data.aws_subnets.private.ids

  // ami_type       = var.ami_type
  // disk_size      = var.disk_size // Set in the launch template
  // instance_types = var.instance_types

  scaling_config {
    desired_size = var.private_desired_size
    max_size     = var.private_max_size
    min_size     = var.private_min_size
  }

  launch_template {
    name = data.aws_launch_template.default.name
    version = data.aws_launch_template.default.latest_version
  }

  //   tags = merge(var.default_tags, map("Name", "your-eks-cluster-ng"))
  tags = {
    Name = format("%s-%s", var.cluster_name, "node-group-private")
  }

/*  lifecycle {
    create_before_destroy = true
    ignore_changes = [scaling_config[0].desired_size, scaling_config[0].min_size]
  }*/

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_worker_node_policy,
    aws_iam_role_policy_attachment.aws_eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_read_only,
  ]
}

# Nodes in public subnet
resource "aws_eks_node_group" "public" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = format("%s-%s", var.cluster_name, "node-group-public")
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = data.aws_subnets.public.ids

  // ami_type       = var.ami_type
  // disk_size      = var.disk_size // Set in the launch template
  // instance_types = var.instance_types

  scaling_config {
    desired_size = var.public_desired_size
    max_size     = var.public_max_size
    min_size     = var.public_min_size
  }

  launch_template {
    name = data.aws_launch_template.default.name
    version = data.aws_launch_template.default.latest_version
  }

  tags = {
    Name = format("%s-%s", var.cluster_name, "node-group-public")
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_worker_node_policy,
    aws_iam_role_policy_attachment.aws_eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_read_only,
  ]
}