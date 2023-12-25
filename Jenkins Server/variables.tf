variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}
