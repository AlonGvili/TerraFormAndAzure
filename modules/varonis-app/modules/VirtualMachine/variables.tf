variable "virtual_machine_count" {
  default     = 0
  description = "How mutch virtual machine do you want to create"
  type        = number
  validation {
    condition = var.virtual_machine_count > 0 ? true : false
    error_message = "You must create at least 1 virtual machine." 
  }
}

variable "admin_username" {
  default     = "vmadmin"
  description = "The local virtual machine admin user name, you cn find more info in here https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm-"
  type        = string
}

variable "admin_password" {
  default     = "P@ssword1"
  description = "The local virtual machine admin password, you can find more info in here https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-password-requirements-when-creating-a-vm-"
  type        = string
  validation {
    condition = length(var.admin_password) > 8 && length(var.admin_password) <= 12
    error_message = "Password length must be between 8 - 12."
  }
}

variable "prefix" {
  default     = ""
  description = "The prefix which should be used for all the load balancer resources"
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure Region where the Load Balancer should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name when all the resources for this load balancer will be created"
  type        = string
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to add to all the resources that accept tags"
}


variable "vnic" {
  description = "Tags to add to all the resources that accept tags"
}