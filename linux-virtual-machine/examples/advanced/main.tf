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
  subscription_id = "50eff175-672d-4308-9b9d-f84337f3f5d1" # Cloud Foundations Subscription. TBD.
  features {}
  skip_provider_registration = true
}

module "vm" {
  source    = "../../"
  providers = { azurerm.foundation = azurerm.foundation }
  module_config = {
    # Mandatory governance parameters
    project     = "cloudops"
    environment = "nonprod"

    # Mandatory VM configuration parameters
    vm_config = {
      name_prefix                = "dfwnpcloudops"
      size                       = "Standard_D2s_v3"
      user_assigned_identity_ids = ["/subscriptions/50eff175-672d-4308-9b9d-f84337f3f5d1/resourceGroups/MC_ftw-rg-cloudops-nonprod-o4im_ftw-aks-cloudops-nonprod-o4im_southcentralus/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ftw-aks-cloudops-nonprod-o4im-agentpool"]
    }

    # Mandatory network configuration parameters
    network_config = {
      vnet_name   = "vnet-foundation-nonprod"
      subnet_name = "private-1"
    }

    # Additional tags in addition to the mandatory ones
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
