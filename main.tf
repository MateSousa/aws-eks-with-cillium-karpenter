module "network" {
  source = "./modules/vpc"

  vpc = {
    name                 = "vpc"
    cidr_block           = "10.30.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
  }
  private_subnets         = ["10.30.48.0/20", "10.30.64.0/20", "10.30.80.0/20"]
  public_subnets          = ["10.30.0.0/24", "10.30.16.0/20", "10.30.32.0/20"]
  map_public_ip_on_launch = true
  environment             = "study"
}

module "eks" {
  source = "./modules/eks"

  eks = {
    name                                        = "eks-cluster"
    version                                     = "1.31"
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
    endpoint_private_access                     = false
    endpoint_public_access                      = true
  }

  vpc = {
    subnets = module.network.public_subnets
    id      = module.network.vpc.id
  }

  addons = {
    coredns    = ""
    vpc-cni    = ""
    kube-proxy = ""
  }

  node_groups = {
    eks_nodes = {
      capacity_type  = "SPOT"
      instance_types = ["t3.medium"]
      desired_size   = 2
      max_size       = 2
      min_size       = 2
    }
  }
}
