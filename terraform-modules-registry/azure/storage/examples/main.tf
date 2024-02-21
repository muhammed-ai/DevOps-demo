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

module "storage_account" {
    source              = "../"
    module_config = {
      project = "cloudops"
      location = "southcentralus"
      resource_group_name = "ibrahim-demoRG"
      subnet_id       = "/subscriptions/"
    environment = "test"
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
