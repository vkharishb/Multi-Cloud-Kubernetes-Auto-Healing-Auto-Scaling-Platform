terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79.0"
    }
  }
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 5.0" #U

    #VPC configuration
    name = var.vpc_name
    cidr = var.cidr_block #CIDR block for the VPC, e.g., "10.0.0.1/16"
    azs             = var.availability_zones #List of availability zones to use for the subnets, e.g., ["us-west-2a", "us-west-2b", "us-west-2c"]
    
    #Subnet configuration for public and private subnets, which will be used by the EKS cluster for worker nodes and other resources
    public_subnets  = var.public_subnet_cidrs #List of CIDR blocks for the public subnets, e.g., ["10.0.0.1/24", "10.0.1.1/24"]
    private_subnets = var.private_subnet_cidrs #List of CIDR blocks for the private subnets, e.g., ["10.0.0.3/24", "10.0.1.3/24"]
    
    #DNS configuration for the VPC, which is required for EKS to function properly
    enable_dns_support   = true #Enable DNS support in the VPC, which allows instances
    enable_dns_hostnames = true #Enable DNS hostnames in the VPC, which is required for EKS to function properly


    #NAT Configuration for private subnets to access the internet
    enable_nat_gateway = true #Enable NAT gateway to allow instances in private subnets to access
    single_nat_gateway = var.environment == "dev" ? true : false #Use a single NAT gateway for all private subnets to reduce costs
    one_nat_gateway_per_az = var.environment == "prod" ? true : false #Use one NAT gateway per availability zone for high availability in production environments)


    #Tags to identify resources created by Terraform and the environment they belong to
    tags = {
        Terraform   = "true"
        Environment = var.environment
    }
}