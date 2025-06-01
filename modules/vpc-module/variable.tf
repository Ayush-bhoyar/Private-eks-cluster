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
