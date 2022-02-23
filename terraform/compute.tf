provider "aws" {
	#credentials provided by environment. Below is an example environment configuration.
	# region = $AWS_REGION (optional)
	# access_key = $AWS_ACCESS_KEY
	# secret_key = $AWS_SECRET_KEY
	# region	 = $AWS_REGION
}

#create EKS cluster and nodegroups.

resource "aws_eks_cluster" "RL-Cluster" {

	name = "RL-Cluster"
	
	#role_arn = "arn:aws:iam::086620157175:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS" #ARN for AWSServiceForEKS.
	role_arn = aws_iam_role.RL-Cluster-Role.arn

	vpc_config {
		subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
	}

	tags = {
		Name = "RL-ALine-Cluster"
	}

	depends_on = [
		aws_iam_role_policy_attachment.RL-AmazonEKSClusterPolicy,
		aws_iam_role_policy_attachment.RL-AmazonEKSVPCResourceController
	]

}

output "EKS-cluster-endpoint" {
	value = aws_eks_cluster.RL-Cluster.endpoint
}

output "EKS-certificate_authority-data" {
	value = aws_eks_cluster.RL-Cluster.certificate_authority[0].data
}

resource "aws_eks_node_group" "RL-pub-ng" {

	cluster_name = aws_eks_cluster.RL-Cluster.name
	node_group_name = "RL-pub-ng"
	node_role_arn = aws_iam_role.RL-Nodegroup-Role.arn
	subnet_ids = aws_subnet.public_subnet.id

	ami_type = var.nodegroup_ami_type
	instance_types = [var.nodegroup_instance_type]

	
}



#create a Loadbalancer.

#create security groups.

#create IAM roles. 

#maybe create EC2 Bastion.

