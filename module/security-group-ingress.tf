resource "aws_security_group" "ingress" {
  name     = format("%s-%s-nlb", var.cluster_name, "node-group")
  description = "Allow connection between NLB and target"
  vpc_id      = data.aws_vpc.main.id
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.ingress.id
  from_port         = "30080"
  to_port           = "30080"
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = [data.aws_vpc.main.cidr_block]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.ingress.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}