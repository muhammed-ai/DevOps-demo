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
      resource_group_name = "DemoRG-1"
    # virtual_network = {
    #   virtual_network_subnet_ids = ["/subscriptions/306eb98e-26d5-4606-b5bc-c57350db64b8/resourceGroups/NetworkRG/providers/Microsoft.Network/virtualNetworks/vnet-platformdep-nonprod-sc01"]
    # }
    environment = "mydevenv01"
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
}
}