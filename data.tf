data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.name

  depends_on = [
    module.eks,
  ]
}

ephemeral "aws_eks_cluster_auth" "auth" {
  name = data.aws_eks_cluster.eks_cluster.id

  depends_on = [
    data.aws_eks_cluster.eks_cluster,
  ]
}


