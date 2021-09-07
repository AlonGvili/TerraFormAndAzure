variable "resource_group_name" {
  type        = string
  description = "The name of the azure resources group to create"
  default     = "varonis-rg"
}

variable "resource_group_location" {
  type        = string
  description = "The name of the azure resources group to create"
  default     = "westeurope"
}

variable "prefix" {
  default     = "dev"
  type        = string
  description = "The prefix to add to all the resources we creating, it will be used in the name attribute"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The azure region name to create all the resources this app needed"
}

variable "virtual_machine_count" {
  default     = 0
  description = "How many virtual machine do you want to create"
}

variable "tags" {
  type = map(string)
  default = {
    environment = "dev"
    department  = "devops"
    costId      = "devops-dev"
  }
  description = "Tags to add to all the resources that accept tags"
}
