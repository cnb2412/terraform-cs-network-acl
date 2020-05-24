# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
}

resource "cloudstack_network_acl" "this" {
  name        = var.name
  vpc_id      = var.vpc_id
  project     = var.project
  description = var.description
}

resource "cloudstack_network_acl_rule" "ingress_rules" {
  count  = length(var.ingress_with_cidr_blocks)
  acl_id = cloudstack_network_acl.this.id

  rule {
    action       = "allow"
    ports        = var.ingress_with_cidr_blocks[count.index].ports
    cidr_list    = var.ingress_with_cidr_blocks[count.index].cidr_list
    protocol     = var.ingress_with_cidr_blocks[count.index].protocol
    traffic_type = "ingress"
  }
}

resource "cloudstack_network_acl_rule" "icmp_rule" {
  count  = var.allow_icmp_echo ? 1 : 0
  acl_id = cloudstack_network_acl.this.id
  rule {
    action       = "allow"
    cidr_list    = ["0.0.0.0/0"]
    traffic_type = "ingress"
    protocol     = "icmp"
    icmp_type    = 8
    icmp_code    = 0
  }
}

resource "cloudstack_network_acl_rule" "egress_rule" {
  count  = var.allow_all_egress ? 1 : 0
  acl_id = cloudstack_network_acl.this.id
  rule {
    action       = "allow"
    cidr_list    = ["0.0.0.0/0"]
    traffic_type = "egress"
    protocol     = "all"
    ports        = ["1-65535"]
  }
}
