terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11, < 4.0"
      configuration_aliases = [ azurerm.dns ]
    }
  }
}