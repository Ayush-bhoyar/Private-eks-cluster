output "eks_role" {
  value = aws_iam_role.EKS_role.arn
}

output "node_role" {
  value = aws_iam_role.Node_role.arn
}
