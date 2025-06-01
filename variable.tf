variable "cidr_range" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "private_subnet_count" {
  type        = number
  description = "Number of private subnets"
}

variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_role_arn" {
  type = string
  description = "IAM role ARN for EKS control plane"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs for EKS"
}

variable "node_role_arn" {
  type = string
  description = "IAM role ARN for EKS worker nodes"
}
