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

#EKS Compute Vars

variable "nodegroup_ami_type" {
    type = string
    description = ""
    default = "ami-033b95fb8079dc481"
}

variable "nodegroup_instance_types" {
    type = list
    description = ""
    default = ["t2.micro"]
}