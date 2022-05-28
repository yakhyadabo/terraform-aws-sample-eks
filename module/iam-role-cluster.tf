#https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html

resource "aws_iam_role" "eks_cluster" {
  name = "${var.service_name}-cluster"
  assume_role_policy = data.aws_iam_policy_document.assume_cluster.json

  #  assume_role_policy = <<POLICY
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "eks.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole"
#    }
#  ]
#}
#POLICY
}

data "aws_iam_policy_document" "assume_cluster" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "aws_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}