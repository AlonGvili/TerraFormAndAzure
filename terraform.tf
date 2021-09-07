terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate2109850524"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}