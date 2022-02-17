provider "aws" {
	#credentials provided by environment. Below is an example environment configuration.
	# region = $AWS_REGION (optional)
	# access_key = $AWS_ACCESS_KEY
	# secret_key = $AWS_SECRET_KEY
	# region	 = $AWS_REGION
}

#create VPC structure, along with subnets.

resource "aws_vpc" "main_vpc" {
	cidr_block = var.VPC_cidr_block

	enable_dns_hostnames = true 

	tags = {
		Name = "RL-Aline-VPC"
	}
}

#resource "public subnet"


#create S3 structure.

#create EKS cluster and nodegroups.

#create security groups.

#create IAM roles. 

#maybe create EC2 Bastion.

