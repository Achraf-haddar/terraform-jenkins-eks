variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Public Subnets"
  type        = list(string)
}
