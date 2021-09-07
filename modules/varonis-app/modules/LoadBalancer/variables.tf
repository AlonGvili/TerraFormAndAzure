variable "location" {
  description = "Specifies the supported Azure Region where the Load Balancer should be created"
}

variable "prefix" {
  description = "The prefix which should be used for all the load balancer resources"
}

variable "resource_group_name" {
  description = "The resource group name when all the resources for this load balancer will be created"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to add to all the resources that accept tags"
}

variable "vnic" {
  description = "Tags to add to all the resources that accept tags"
}

