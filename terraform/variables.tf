
variable "AWS_Access_Key" {
    type = string
    description = "Access Key used to authenticate access into AWS API."
    sensitive = true
    nullable = true
}

variable "AWS_Secret_Key" {
    type = string
    description = "Secret Key used to authenticate access into AWS API."
    sensitive = true
    nullable = true
}

variable "region" {
    type = string
    description = "region to be used to deploy infrastructure on AWS."
    default = "us-west-1"
}

variable "VPC_cidr_block" {
    type = string
    description = "CIDR block used by VPC instance."
    default = "10.1.0.0/16"
}