resource "aws_security_group" "snowplow_sg" {
  name        = "snowplow_sg"
  description = "Consul servers"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports_tcp
    content {
      from_port = port.value
      protocol = "tcp"
      to_port = port.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_ports_tcp
    content {
      from_port = port.value
      protocol = "tcp"
      to_port = port.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

resource "aws_security_group_rule" "consul_internal_egress_tcp" {
  security_group_id        = aws_security_group.snowplow_sg.id
  type                     = "egress"
  from_port                = 8300
  to_port                  = 8600
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.snowplow_sg.id
}

resource "aws_security_group_rule" "consul_internal_egress_udp" {
  security_group_id        = aws_security_group.snowplow_sg.id
  type                     = "egress"
  from_port                = 8300
  to_port                  = 8600
  protocol                 = "udp"
  source_security_group_id = aws_security_group.snowplow_sg.id
}

resource "aws_security_group_rule" "consul_serf_tcp" {
  security_group_id        = aws_security_group.snowplow_sg.id
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.snowplow_sg.id
}

resource "aws_security_group_rule" "consul_serf_udp" {
  security_group_id        = aws_security_group.snowplow_sg.id
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "udp"
  source_security_group_id = aws_security_group.snowplow_sg.id
}

// This rule allows Consul DNS.
resource "aws_security_group_rule" "consul_dns_udp" {
  security_group_id        = aws_security_group.snowplow_sg.id
  type                     = "ingress"
  from_port                = 8600
  to_port                  = 8600
  protocol                 = "udp"
  source_security_group_id = aws_security_group.snowplow_sg.id
}
