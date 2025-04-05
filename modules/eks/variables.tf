variable "eks" {
  type = object({
    name                                        = string
    version                                     = string
    authentication_mode                         = string
    bootstrap_cluster_creator_admin_permissions = bool
    endpoint_private_access                     = bool
    endpoint_public_access                      = bool
  })
}

variable "vpc" {
  type = object({
    subnets = list(string)
    id      = string
  })
}

variable "addons" {
  type = map(string)
}

variable "node_groups" {
  type = map(object({
    capacity_type  = string
    instance_types = list(string)
    desired_size   = number
    max_size       = number
    min_size       = number
  }))
}
