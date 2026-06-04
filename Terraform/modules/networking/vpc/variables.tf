variable "vpc_name" {
    description = "Name of the VPC to create"
    type        = string
    default     = "AHAKS-VPC"
}

variable "cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "availability_zones" {
    description = "List of availability zones for the VPC"
    type        = list(string)
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for the public subnets"
    type        = list(string)
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for the private subnets"
    type        = list(string)
}

variable "region" {
    description = "AWS region to deploy the VPC"
    type        = string
    default     = "ap-south-2"
}