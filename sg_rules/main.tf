
resource "aws_security_group" "assign" {
    name = var.name
    description = var.description
   # vpc_id = var.vpc_id
   # ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
}

resource "aws_vpc_security_group_ingress_rule" "inbound" {
  security_group_id = aws_security_group.assign.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.assign.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
