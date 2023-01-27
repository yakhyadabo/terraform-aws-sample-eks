resource "aws_launch_template" "default" {
  name_prefix     = join("-", [var.service_name, var.environment])
  vpc_security_group_ids = [aws_security_group.ingress.id, aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]

 // instance_type = "t3.medium"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.disk_size
      volume_type = "gp2"
    }
  }

  // See : https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html

/*  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -ex
/etc/eks/bootstrap.sh my-cluster \
  --b64-cluster-ca certificate-authority \
  --apiserver-endpoint api-server-endpoint \
  --dns-cluster-ip service-cidr.10 \
  --container-runtime containerd \
  --kubelet-extra-args '--max-pods=my-max-pods-value' \
  --use-max-pods false
--==MYBOUNDARY==--\

  EOF
  )*/

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = join("-", [var.service_name, var.environment,"node-group"])
      "kubernetes.io/cluster/eks" = "owned"
    }
  }
}