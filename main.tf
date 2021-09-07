terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.75.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

locals {
  region   = "eastus2"
  location = ["northeurope", "eastus2"]
  prefix   = "prod"
  rgname   = "vag"
}

module "varonis-app" {
  count                   = length(local.location)
  source                  = "./modules/varonis-app"
  location                = local.location[count.index]
  prefix                  = local.prefix
  resource_group_name     = local.rgname
  resource_group_location = local.region
  virtual_machine_count   = 2
  tags = {
    "environment" = "dev"
  }
}
