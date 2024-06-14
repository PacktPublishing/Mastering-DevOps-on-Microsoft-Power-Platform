terraform {
  backend "azurerm" {
    storage_account_name = "__storageaccountname__"  #change to match Azure Storage account
    container_name       = "__containername__"  #change to match container name of Azure Storage account
    key                  = "terraform.tfstate"  # name of terraform state file
    resource_group_name  = "__resourcegroup__" # change to match Azure Resource Group
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.107" # change to the latest version
    }
    powerplatform = {
      source = "microsoft/power-platform"
      version = "2.3.1-preview" # change to the latest version
    }
  } 
}

provider "azurerm" {
  features {}
}

provider "powerplatform" {
    # We will use a service principal to authenticate with the Power Platform service
    client_id     = var.client_id
    client_secret = var.client_secret
    tenant_id     = var.tenant_id
}