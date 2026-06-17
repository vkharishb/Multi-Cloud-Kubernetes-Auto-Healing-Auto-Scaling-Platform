terraform {
  backend "s3" {
    bucket       = "mcp-dev-tfstate"
    key          = "dev/aws/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}