module "vpc" {
  source = "./modules/vpc-module"
  cidr_range = var.cidr_range
  private_subnet_count = var.private_subnet_count
  public_subnet_count = var.public_subnet_count
  cluster_name = var.cluster_name
}

module "iam" {
  source = "./modules/iam-module"

}

module "eks" {
  source = "./modules/eks-module"
  eks_role_arn = module.iam.eks_role
  node_role_arn = module.iam.node_role
  cluster_name = var.cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids

}
