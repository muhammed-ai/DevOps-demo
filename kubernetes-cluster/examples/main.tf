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
  subscription_id = "50eff175-672d-4308-9b9d-f84337f3f5d1"
}

module "k8s" {
  source    = "../"
  module_config = {
    # Mandatory governance parameters
    project     = "cloudops"
    environment = "nonprod"

    # Mandatory k8s configuration parameters
    k8s_config = {
      name_prefix = "ftw"
      node_count  = "2"
      min_node_count   = "1"
      max_node_count   = "4"
    }

    # Mandatory network configuration parameters
    network_config = {
      vnet_name        = "vnet-foundation-nonprod"
      subnet_name      = "private-1"
    }

    # Additional tags in addition to the mandatory ones
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
