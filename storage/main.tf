# Purpose: Create a storage account and containers if specified in the module_config
module "naming" {
  source = "../naming"
  suffix = [var.module_config.project, local.app, var.module_config.environment]
}

# Create a resource group if it is not specified in the module_config
resource "azurerm_resource_group" "rg" {
  count    = try(var.module_config.resource_group_name, null) == null ? 1 : 0
  name     = module.naming.resource_group.name
  location = local.location
}

# Create a storage account
resource "azurerm_storage_account" "sa" {
  name                            = coalesce(var.module_config.name, module.naming.storage_account.name_unique)
  resource_group_name             = local.resource_group_name
  location                        = local.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  tags                            = local.module_tags

  # network_rules {
  #   default_action             = "Deny"
  #   virtual_network_subnet_ids = data.azurerm_subnet.subnet_ids[*].id
  # }

  blob_properties {
    change_feed_enabled      = true
    versioning_enabled       = true
    last_access_time_enabled = true

    container_delete_retention_policy {
      days = "7"
    }

    delete_retention_policy {
      days = "7"
    }
  }

  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
}

# Create containers if the value is passed
resource "azurerm_storage_container" "containers" {
  for_each              = toset(local.containers)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.sa]
}
