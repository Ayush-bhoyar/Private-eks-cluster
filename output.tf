output "EKS_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "eks_cluster_end_point" {
  value = module.eks.eks_cluster_end_point

}

output "Eks_cluster_certificate_authority" {
  value = module.eks.cluster_certificate_authority
}

