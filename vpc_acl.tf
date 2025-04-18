locals {
  restricted_ports = {
    ssh = 22
    rdp = 3389
  }
}

resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.vpc.name}-acl"
    Type        = "acl"
    Environment = var.environment
  }
}

resource "aws_network_acl_rule" "no_open_ingress" {
  for_each       = local.restricted_ports
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100 + each.value
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"

  from_port = each.value
  to_port   = each.value
}


