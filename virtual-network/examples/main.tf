## Provider Configuration
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

# DNS Subscription provider for the DNS Forwarding Ruleset
provider "azurerm" {
  features {}
  subscription_id = "e96f730e-8b9b-4fbd-8c51-34a35f326acb" # dns-prod subscription
  alias           = "dns"
}

# Call the module.
module "network" {
  source = "../"

  providers = {
    azurerm.dns = azurerm.dns
  }

  # Pass the required parameters to the module
  module_config = {
    project     = "cloudops"
    environment = "nonprod"

    # Setup the network configuration
    network_config = {
      cidr = "10.0.0.0/16"
      subnets = [
        {
          name = "private-1"
          cidr = "10.0.1.0/24"
        },
        {
          name = "private-2"
          cidr = "10.0.2.0/24"
          delegations = [
            {
              name         = "delegation1"
              service_name = "Microsoft.Netapp/volumes"
              actions      = []
            }
          ]
        }
      ]
    }

    # Pass the additional tags to the module
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}


# All the outputs.
output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.network.vnet_id
}
output "vnet_name" {
  description = "The name of the newly created vNet"
  value       = module.network.vnet_name
}
output "vnet_rg" {
  description = "The name of the resource group where the vNet is created"
  value       = module.network.vnet_rg
}
output "vnet_subnets" {
  description = "The ids of subnets created inside the newly vNet"
  value       = module.network.vnet_subnets
}
