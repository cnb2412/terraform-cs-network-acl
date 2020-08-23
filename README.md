# Apache Cloudstack Network ACL Terraform module

Terraform module which creates network ACLs for VPCs in Apache CloudStack
environments.

These types of resources are supported:

* [Network ACL](https://www.terraform.io/docs/providers/cloudstack/r/network_acl.html)
* [Network ACL Rule](https://www.terraform.io/docs/providers/cloudstack/r/network_acl_rule.html)


## Usage

```hcl
module "vpc" {
  source = "github.com/cnb2412/terraform-cs-network-acl"
  name = "my-acl"
  description = "my-acl-description"
  vpc_id = "76f6e8dc-07e3-4971-b2a2-8831b0cc4cb4"

  # optional parameters
  allow_icmp_echo = true
  allow_all_egress = true

  ingress_with_cidr_blocks = [
    {
      ports   = ["22"]
      protocol    = "tcp"
      cidr_list = ["0.0.0.0/0"]
    }
  ]
}
```

## Limitations

Currently only custom rules for ingress traffic can be managed. 
All egress traffic can only be explicitly allowed for all ports and all traffic.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| cloudstack | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_all\_egress | Allow all egress traffic | `bool` | `false` | no |
| allow\_icmp\_echo | Allow ICMP echo request | `bool` | `false` | no |
| description | The description of the ACL. | `string` | `""` | no |
| ingress\_with\_cidr\_blocks | Custom ingress rules | `list(object({ cidr_list = list(string), protocol = string, ports = list(string) }))` | `[]` | no |
| name | The name of the ACL. | `string` | n/a | yes |
| project | he name or ID of the project to deploy this instance to. Changing this forces a new resource to be created. | `string` | `""` | no |
| vpc\_id | The ID of the VPC to create this ACL for. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the network ACL |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
