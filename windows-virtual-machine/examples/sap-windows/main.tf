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
    project     = "sap"
    environment = "nonprod"

    # Mandatory VM configuration parameters
    vm_config = {
      name = "saptestvm"
      size = "Standard_D2s_v3"
    }

    # Mandatory network configuration parameters
    network_config = {
      vnet_name   = "vnet-sap-nonprod"
      subnet_name = "private-1"
    }

    # Additional tags in addition to the mandatory ones
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}

output "vm_id" {
  value = module.vm.vm_id
}
output "vm_name" {
  value = module.vm.vm_name
}
output "vm_identity" {
  value = module.vm.vm_identity
}
output "vm_ipaddr" {
  value = module.vm.vm_ipaddr
}
