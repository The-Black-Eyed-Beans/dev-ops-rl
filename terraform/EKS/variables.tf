#Network Vars
variable "VPC_cidr_block" {
    type = string
    description = "CIDR block used by VPC instance."
    default = "10.1.0.0/16"
}

variable "private_subnet_cidr_block" {
    type = string
    description = ""
    default = "10.1.1.0/24"
}

variable "public_subnet_cidr_block" {
    type = string
    description = ""
    default = "10.1.2.0/24"
}

variable "public_subnet_availability_zone" {
    type = string
    description = ""
    default = "us-west-1a"
}

variable "private_subnet_availability_zone" {
    type = string
    description = ""
    default = "us-west-1c"
}

#EKS Compute Vars

variable "nodegroup_instance_types" {
    type = list
    description = ""
    default = ["t2.micro"]
}

#AWS Credentials, CHANGE LATER

variable "aws_access_key" {
    type = string
    description = ""
    sensitive = true
}

variable "aws_secret_key" {
    type = string
    description = ""
    sensitive = true
}

variable "aws_region" {
    type = stringg
    description = ""
    sensitive = true
}