#Network Vars
variable "VPC_cidr_block" {
  type        = string
  description = "CIDR block used by VPC instance."
  default     = "10.1.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks used by the private subnets. Should contain the same amount of elements as the public_subnet_cidr_blocks."
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks used by the public subnets. Should contain the same amount of elements as the private_subnet_cidr_blocks. Also used to determine amount of subnets to be created. "
  default     = ["10.1.3.0/24", "10.1.4.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = ""
  default     = ["us-west-1a", "us-west-1c"]
}
