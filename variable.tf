# --------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters needs to be configured
# --------------------------------------------------------------------------
variable "name" {
  description = "The name of the ACL."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to create this ACL for."
}


# --------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# --------------------------------------------------------------------------


variable "description" {
  description = "The description of the ACL."
  type        = string
  default     = ""
}

variable "project" {
  description = "he name or ID of the project to deploy this instance to. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "ingress_with_cidr_blocks" {
  description = "Custom ingress rules"
  type        = list(object({ cidr_list = list(string), protocol = string, ports = list(string) }))
  default     = []
}

variable "allow_icmp_echo" {
  description = "Allow ICMP echo request"
  type        = bool
  default     = false
}

variable "allow_all_egress" {
  description = "Allow all egress traffic"
  type        = bool
  default     = false
}