
provider "aws" {
	#credentials provided by environment. Below is an example environment configuration.
	# access_key = $AWS_ACCESS_KEY
	# secret_key = $AWS_SECRET_KEY
	# region	 = $AWS_REGION

	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
	region = var.aws_region
}

terraform{
    backend "s3" {

        bucket = "rl-terraform-s3"
        key = "terraform/terraform.tfstate"
        region = "us-west-1"

    }
}

module "network" {
    source = "./modules/network"
    VPC_cidr_block = var.VPC_cidr_block
    private_subnet_cidr_block = var.private_subnet_cidr_block
    public_subnet_cidr_block = var.public_subnet_cidr_block
    public_subnet_availability_zone = var.public_subnet_availability_zone
    private_subnet_availability_zone = var.private_subnet_availability_zone
}