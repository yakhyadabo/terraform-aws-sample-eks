resource "aws_security_group" "ingress" {
  name_prefix     = join("-", [var.service_name, var.environment,"nlb-"])
  description = "Allow connection between NLB and target"
  vpc_id      = data.aws_vpc.main.id
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.ingress.id
  from_port         = "30080"
  to_port           = "30080"
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.ingress.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}