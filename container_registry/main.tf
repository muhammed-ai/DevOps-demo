module "naming" {
  source = "../naming"
  suffix = [var.module_config.project, var.module_config.environment]
}
# Create the azure container registry
resource "azurerm_container_registry" "acr" {
  #name                      = "bnsfecpfnd${var.environment}acr"
  name                       = coalesce(var.module_config.name, module.naming.container_registry.name_unique)
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = local.default_location
  sku                        = "Premium"
  admin_enabled              = true
  network_rule_bypass_option = "AzureServices"
  data_endpoint_enabled      = true
  tags                       = local.module_tags
  lifecycle {
    ignore_changes = [
      tags["CreationDate"]
    ]
  }
}