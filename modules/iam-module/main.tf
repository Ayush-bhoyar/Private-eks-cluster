resource "aws_iam_role" "EKS_role" {
  name= "Eks-role"
  assume_role_policy= data.aws_iam_policy_document.eks_assume_role.json

}
resource "aws_iam_role_policy_attachment" "Eks_policy" {
  role = aws_iam_role.EKS_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}

resource "aws_iam_role" "Node_role" {
  name = "Node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  role = aws_iam_role.Node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}
resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  role = aws_iam_role.Node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}
resource "aws_iam_role_policy_attachment" "node_CloudWatchAgentServerPolicy" {
  role = aws_iam_role.Node_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "node_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
