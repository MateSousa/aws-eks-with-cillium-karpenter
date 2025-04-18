variable "aws_region" {
  description = "AWS region to deploy the EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "production"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "eks_addons" {
  description = "EKS Addons to be installed"
  type = map(object({
    version                     = string
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    configuration_values        = optional(string, "")
    service_account_role_arn    = optional(string, "")
    pod_identity_association = optional(object({
      role_arn        = optional(string, "")
      service_account = optional(string, "")
    }))
  }))
  default = {
    coredns = {
      version                     = "v1.11.4-eksbuild.2"
      resolve_conflicts_on_update = "OVERWRITE"
      resolve_conflicts_on_create = "OVERWRITE"
      configuration_values        = ""
      pod_identity_association    = null
    }
    kube-proxy = {
      version                     = "v1.32.0-eksbuild.2"
      resolve_conflicts_on_update = "OVERWRITE"
      resolve_conflicts_on_create = "OVERWRITE"
      configuration_values        = ""
      pod_identity_association    = null
    }
  }
}

variable "eks" {
  description = "EKS cluster configuration"
  type = object({
    name                                        = string
    version                                     = string
    authentication_mode                         = string
    bootstrap_cluster_creator_admin_permissions = bool
    endpoint_private_access                     = bool
    endpoint_public_access                      = bool
    api_allowed_cidrs                           = list(string)
    encryption_enabled                          = bool
  })
  default = {
    name                                        = "my-eks-cluster"
    version                                     = "1.32"
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
    endpoint_private_access                     = true
    endpoint_public_access                      = true
    api_allowed_cidrs                           = ["0.0.0.0/0"]
    encryption_enabled                          = true
  }
}

variable "node_groups" {
  description = "Node groups configuration"
  type = map(object({
    capacity_type  = string
    instance_types = list(string)
    labels         = map(string)
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
    desired_size = number
    max_size     = number
    min_size     = number
  }))
  default = {
    karpenter = {
      capacity_type  = "SPOT"
      instance_types = ["t3.medium"]
      desired_size   = 2
      max_size       = 2
      min_size       = 2
      labels = {
        "karpenter.sh/controller" = "true"
      }
      taints = [
        {
          key    = "node.cilium.io/agent-not-ready"
          value  = "true"
          effect = "NO_EXECUTE"
        }
      ]
    }
  }
}

variable "vpc" {
  description = "VPC configuration"
  type = object({
    name                 = string
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })
  default = {
    name                 = "vpc"
    cidr_block           = "10.30.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
  }
}

variable "private_subnets" {
  description = "List of private subnets for the EKS cluster"
  type        = list(string)
  default     = ["10.30.48.0/20", "10.30.64.0/20", "10.30.80.0/20"]
}

variable "public_subnets" {
  description = "List of public subnets for the EKS cluster"
  type        = list(string)
  default     = ["10.30.0.0/24", "10.30.16.0/20", "10.30.32.0/20"]
}

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch for the public subnets"
  type        = bool
  default     = true
}

variable "deploy_provisioners" {
  description = "Flag to deploy provisioners"
  type        = bool
  default     = true
}

variable "provisioner_manifests_paths" {
  description = "Paths to provisioner manifests"
  type        = string
  default     = "./karpenter/manifests/provisioners/*.yaml"
}

variable "karpenter_queue" {
  description = "Karpenter queue configuration"
  type = object({
    name                              = string
    managed_sse_enabled               = bool
    kms_master_key_id                 = string
    kms_data_key_reuse_period_seconds = number
    prefix                            = string
  })
  default = {
    name                              = "karpenter-queue"
    managed_sse_enabled               = true
    kms_master_key_id                 = null
    kms_data_key_reuse_period_seconds = null
    prefix                            = "karpenter-queue"
  }
}

variable "cillium" {
  description = "Cilium configuration"
  type = object({
    chart_repository  = string
    namespace         = string
    version           = string
    hubble_enabled    = bool
    hubble_ui_enabled = bool
    sets              = map(string)
  })
  default = {
    chart_repository  = "https://helm.cilium.io/"
    namespace         = "kube-system"
    version           = "1.17.2"
    hubble_enabled    = true
    hubble_ui_enabled = true
    sets = {
      "eni.enabled"                = "true"
      "ipam.mode"                  = "eni"
      "egressMasqueradeInterfaces" = "eth0"
      "routingMode"                = "native"
    }
  }
}

