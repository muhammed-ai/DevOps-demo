provider "azurerm" {
    features {
    }
}

resource "azurerm_resource_group" "Demo" {
  name     = "DemoRG-1"
  location = "Central US"
}
