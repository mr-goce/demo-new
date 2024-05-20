terraform {
  backend "azurerm" {
    resource_group_name  = "demo-rg"
    storage_account_name = "0101984sa"
    container_name       = "dev-backend-terraform"
    key                  = "prod.terraform.tfstate"
  }
}