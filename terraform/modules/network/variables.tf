#Network Vars
variable "VPC_cidr_block" {
  type        = string
  description = "CIDR block used by VPC instance."
  default     = "10.1.0.0/16"
}

#potentially delete later
variable "private_subnet_cidr_block" {
  type        = string
  description = ""
  default     = "10.1.1.0/24"
}

#potentially delete later
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

variable "availability_zones" {
  type        = list(string)
  description = ""
  default     = ["us-west-1a", "us-west-1c"]
}
