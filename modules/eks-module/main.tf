resource "aws_eks_cluster" "EKS" {
  role_arn = var.eks_role_arn
  name = var.cluster_name

  vpc_config {
    subnet_ids = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access = true
    public_access_cidrs = [ "13.126.154.173/32" ] #this is my bastion host ip from which i can access my cluster

  }

  tags = {
    Name= var.cluster_name
  }
}

resource "aws_eks_node_group" "Eks_node" {
  cluster_name = aws_eks_cluster.EKS.name
  node_group_name = "${var.cluster_name}-nodegroup"
  node_role_arn = var.node_role_arn
  subnet_ids = var.private_subnet_ids

scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

instance_types = ["t3.medium"]
  ami_type       = "AL2_x86_64"
  disk_size      = 20

tags = {
    Name = "eks-node-group"
  }
}


