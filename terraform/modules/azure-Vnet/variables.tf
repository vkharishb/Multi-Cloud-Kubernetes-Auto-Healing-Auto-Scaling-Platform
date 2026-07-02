variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network will be created."
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to create within the virtual network."
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "tags" {
  description = "A map of tags to assign to the virtual network and its subnets."
  type        = map(string)
  default     = {}
}
