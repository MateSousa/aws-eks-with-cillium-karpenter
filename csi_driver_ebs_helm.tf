resource "aws_iam_role" "csi_driver_ebs" {
  name               = "csi-driver-ebs-${var.eks_cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.csi_driver_ebs_pod_identity_association.json
}

resource "aws_iam_role_policy_attachment" "csi_driver_ebs_policy_attachment" {
  role       = aws_iam_role.csi_driver_ebs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy_document" "csi_driver_ebs_pod_identity_association" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_eks_pod_identity_association" "csi_driver_ebs_pods_identity_association" {
  cluster_name    = var.eks_cluster_name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.csi_driver_ebs.arn

  depends_on = [
    aws_iam_role_policy_attachment.csi_driver_ebs_policy_attachment,
  ]
}

resource "helm_release" "csi_driver_ebs" {
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = var.csi_driver_ebs_version

  depends_on = [
    aws_eks_cluster.cluster,
    aws_iam_role.csi_driver_ebs,
    aws_iam_role_policy_attachment.csi_driver_ebs_policy_attachment,
    aws_eks_pod_identity_association.csi_driver_ebs_pods_identity_association,
  ]
}

resource "kubectl_manifest" "storage_class_gp3" {
  yaml_body = <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gp3
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
EOF

  depends_on = [
    helm_release.csi_driver_ebs,
  ]
}
