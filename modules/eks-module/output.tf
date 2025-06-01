output "eks_cluster_end_point" {
  value = aws_eks_cluster.EKS.endpoint
}
output "eks_cluster_name" {
  value = aws_eks_cluster.EKS.name
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}
