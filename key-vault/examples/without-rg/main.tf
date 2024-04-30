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

provider "azurerm" {
  alias           = "foundation"
  subscription_id = "50eff175-672d-4308-9b9d-f84337f3f5d1"
  features {}
}

module "keyvault" {
  source = "../../"

  providers = {
    azurerm            = azurerm
    azurerm.foundation = azurerm.foundation
  }

  module_config = {
    project             = "cloudops"
    environment         = "nonprod"
    access_ids          = ["ad128605-f62f-4d60-b08a-78ecdd08d894", "1a6f7a00-b1c4-4d5a-9704-084e990be688"]
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
