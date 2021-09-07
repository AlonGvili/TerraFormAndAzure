variable "prefix" {
  default     = ""
  description = "The prefix which should be used for all the load balancer resources"
  type        = string
}

variable "location" {
  default     = ""
  description = "Specifies the supported Azure Region where the Load Balancer should be created"
  type        = string
}

variable "resource_group_name" {
  default     = ""
  description = "The resource group name when all the resources for this load balancer will be created"
  type        = string
}

variable "load_balancer_name" {
  description = "The name of the load balancer"
  type = string
  validation {
    condition = var.load_balancer_name != null
    error_message = "You must provide load balancer name to associate it with this traffic manager."
  }
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to add to all the resources that accept tags"
}