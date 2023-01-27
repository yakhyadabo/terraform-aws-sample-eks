resource "aws_launch_template" "default" {
  name_prefix     = join("-", [var.service_name, var.environment])
  vpc_security_group_ids = [aws_security_group.ingress.id, aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.disk_size
      volume_type = var.volume_type
    }
  }

  // See : https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html

  tags = {
    "eks:cluster-name"   = aws_eks_cluster.main.name
    "eks:nodegroup-name" = join("-", [var.service_name, var.environment,"node-group"])
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = join("-", [var.service_name, var.environment,"node-group"])
      "kubernetes.io/cluster/eks" = "owned"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      "eks:cluster-name"   =  aws_eks_cluster.main.name
      "eks:nodegroup-name" = join("-", [var.service_name, var.environment,"node-group"])
    }
  }
}