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
  source = "../.."
  module_config = {
    project     = "cloudops"
    environment = "nonprod"
    resource_group_name = "cloudops-nonprod-rg"
    containers = ["container1", "container2"]
    network_config = {
      subnet_names = ["bnsf-vm-subnet1", "bnsf-vm-subnet2"]
      vnet_name    = "bnsf-vm-network"
      vnet_rg      = "bnsf-vm"
    }
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
