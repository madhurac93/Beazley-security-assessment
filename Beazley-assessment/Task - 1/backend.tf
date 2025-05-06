terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

   backend "azurerm" {
    resource_group_name  = "Enter RG name"
    storage_account_name = "Enter storage account name"     
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
