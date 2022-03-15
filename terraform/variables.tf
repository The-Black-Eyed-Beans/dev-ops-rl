#Network Vars
variable "VPC_cidr_block" {
  type        = string
  description = "CIDR block used by VPC instance."
  default     = "10.1.0.0/16"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = ""
  default     = "10.1.1.0/24"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = ""
  default     = "10.1.2.0/24"
}

variable "public_subnet_availability_zone" {
  type        = string
  description = ""
  default     = "us-west-1a"
}

variable "private_subnet_availability_zone" {
  type        = string
  description = ""
  default     = "us-west-1c"
}

#New Network Vars

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = ""
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = ""
  default     = ["10.1.3.0/24", "10.1.4.0/24"]
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
    type = string
    description = ""
    sensitive = true
}