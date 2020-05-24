provider "cloudstack" {
}

locals {
  zone = "Enterprise_Internet_Bi"
}

###########################
# Network ACL example
###########################


# Create a test VPC
module "test_vpc" {
  source       = "github.com/cnb2412/terraform-cs-vpc"
  name         = "network-acl-test-vpc"
  cidr         = "10.0.0.0/16"
  vpc_offering = "Default VPC offering"
  zone         = local.zone
}

# SSH
module "ssh_acl" {
  source = "../../"

  name        = "allow-ssh-acl"
  description = "Network ACL with SSH port open for everybody, egress ports are all world open"
  vpc_id      = module.test_vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      ports     = ["22"]
      protocol  = "tcp"
      cidr_list = ["0.0.0.0/0"]
    }
  ]
}