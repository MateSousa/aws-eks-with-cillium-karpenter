variable "vpc" {
  description = "Variables for VPC"
  type = object({
    name                 = string
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })
}

variable "environment" {
  description = "Type of environment"
  type        = string
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Map Public IP on Launch"
  type        = bool
  default     = false
}

