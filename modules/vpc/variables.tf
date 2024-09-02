variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "region" {
  description = "The region where the VPC subnet will be created"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_cidrs" {
  description = "The CIDR ranges for the subnets"
  type        = list(string)
}