terraform {
  backend "azurerm" {
    resource_group_name  = "dev-tfs-rg22198"
    storage_account_name = "devtfs16242"
    container_name       = "devtfs13867"
    key                  = "terraform.tfstate"
  }
}