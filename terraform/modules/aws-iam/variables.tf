variable "name" {
    description = "Project name"
    type        = string
    default     = "mcp"
}

variable "env" {
    description = "Environment (e.g., dev, prod)"
    type        = string
    default     = "dev"
}
variable "tags" {
  description = "Common tags for all IAM resources"
  type        = map(string)
  default     = {}
}