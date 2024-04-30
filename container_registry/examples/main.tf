terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11, < 4.0"
    }
  }
}
provider "azurerm" {
  features {}
}

module "acr" {
  source    = "../"
  module_config = {
    project             = "cloudops"
    environment         = "nonprod"
    resource_group_name = "cloudops-nonprod-rg"

    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
