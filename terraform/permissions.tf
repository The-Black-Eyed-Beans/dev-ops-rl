#Permissions for EKS Cluster and Nodegroups.

#EKS Cluster Role and policies.

resource "aws_iam_role" "RL-Cluster-Role" {
    
    name = "RL-Cluster-Role"

    assume_role_policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
      ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "RL-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.RL-Cluster-Role.name
}

resource "aws_iam_role_policy_attachment" "RL-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.RL-Cluster-Role.name
}

#EKS Nodegroup role and policies.


resource "aws_iam_role" "RL-Nodegroup-Role" {

  name = "RL-Nodegroup-Role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "RL-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.RL-Nodegroup-Role.name
}

resource "aws_iam_role_policy_attachment" "RL-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.RL-Nodegroup-Role.name
}

resource "aws_iam_role_policy_attachment" "RL-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.RL-Nodegroup-Role.name
}