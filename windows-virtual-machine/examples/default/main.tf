# This is default example where minimum parameters are passed to the module. 
# Rest of the parameters are defaulted to the values defined in the module.

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

# Calling the module with minimum parameters
module "vm" {
  source    = "../../"
  providers = { azurerm.foundation = azurerm.foundation }
  module_config = {
    # Mandatory governance parameters
    project     = "cloudops"
    environment = "nonprod"

    # Mandatory VM configuration parameters
    vm_config = {
      size = "Standard_D2s_v3"
    }

    # Mandatory network configuration parameters
    network_config = {
      vnet_name   = "vnet-platformdep-nonprod-sc01"
      subnet_name = "platformdep-nonprod-subnet"
    }

    # Additional tags in addition to the mandatory ones
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
