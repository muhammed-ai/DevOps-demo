# Calling the naming module to get the resource group name and other naming conventions
module "naming" {
  source = "../naming"
  suffix = [var.module_config.project, var.module_config.environment]
}

# Create a resource group which will contain all the resources for this module
resource "azurerm_resource_group" "rg" {
  name     = var.module_config.vm_config.name != null ? "${var.module_config.vm_config.name}-rg-${random_string.unique.result}" : (var.module_config.vm_config.name_prefix == null ? "${module.naming.resource_group.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}w-rg-${random_string.unique.result}" : null}")
  location = local.default_location
  tags     = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
}

resource "random_string" "unique" {
  length  = 3
  special = false
  upper   = false
  numeric = true
}
