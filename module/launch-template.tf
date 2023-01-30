data "aws_launch_template" "default" {
  name = aws_launch_template.default.name
  depends_on = [aws_launch_template.default]
}

resource "aws_launch_template" "default" {
  name     = join("-", [var.service_name, var.environment])
  vpc_security_group_ids = [aws_security_group.ingress.id, aws_eks_cluster.main.vpc_config[0].cluster_security_group_id]
  key_name = var.key_name

  instance_type = var.instance_types[0]
  image_id                = data.aws_ami.eks_node.image_id
  user_data = base64encode(templatefile("${path.module}/userdata.tpl", {
     cluster_name = aws_eks_cluster.main.name
     cluster_ca_base64 = aws_eks_cluster.main.certificate_authority[0].data
     api_server_url = aws_eks_cluster.main.endpoint
  }))

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.disk_size
      volume_type = var.volume_type
    }
  }

  // See : https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html
  // See : https://github.com/aws-samples/terraform-eks-code/blob/master/nodeg/launch_template.tf

  tags = {
    "eks:cluster-name"   = aws_eks_cluster.main.name
    "eks:nodegroup-name" = join("-", [var.service_name, var.environment,"node-group"])
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = join("-", [var.service_name, var.environment,"node-group"])
      "kubernetes.io/cluster/eks-cluster-dev" = "owned"
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

data "aws_ami" "eks_node" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = [format("amazon-eks-node-%s-*", aws_eks_cluster.main.version)]
  }
}