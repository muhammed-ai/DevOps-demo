locals {
  replications = flatten([
    for repl_key, repl in try(var.container_registry_base["replications"], {}) : {
      repl_key                  = repl_key
      location                  = repl.location
      zone_redundancy_enabled   = try(repl["enable_zone_redundancy"], false)
      regional_endpoint_enabled = try(repl["regional_endpoint_enabled"], false)
    }
  ])
}

resource "azurerm_user_assigned_identity" "instance_identity" {
  for_each = var.container_registry_base
  location            = each.value.location
  name                = each.value.identity_name == null ? "${module.naming.user_assigned_identity.name}-${each.key}" : each.value.identity_name
  resource_group_name = each.value.resource_group_name == null ? "${module.naming.resource_group.name}-${each.key}" : each.value.resource_group_name
}

resource "azurerm_container_registry" "instance" {
  for_each = var.container_registry_base

  name                = each.value.name == null ? "${module.naming.container_registry.name}${each.key}" : each.value.name
  resource_group_name = each.value.resource_group_name == null ? "${module.naming.resource_group.name}-${each.key}" : each.value.resource_group_name
  location            = each.value.location

  sku                        = try(each.value.sku, "Standard")
  admin_enabled              = try(each.value.enable.admin, false)
  quarantine_policy_enabled  = try(each.value.enable.quarantine_policy, false)
  network_rule_bypass_option = try(each.value.network_rule_bypass, "AzureServices")

  anonymous_pull_enabled = each.value.sku == "Standard" || each.value.sku == "Premium" ? try(each.value.enable.anonymous_pull, false) : false

  data_endpoint_enabled = each.value.sku == "Premium" ? try(each.value.enable.data_endpoint, false) : false

  export_policy_enabled = each.value.sku == "Premium" && try(each.value.enable.public_network_access, true) == false ? try(each.value.enable.export_policy, true) : true

  public_network_access_enabled = try(each.value.enable.public_network_access, false)

  dynamic "trust_policy" {
    for_each = each.value.sku == "Premium" && try(each.value.enable.trust_policy, false) == true ? [1] : []

    content {
      enabled = each.value.enable.trust_policy
    }
  }

  dynamic "retention_policy" {
    for_each = each.value.sku == "Premium" && try(each.value.enable.retention_policy, false) == true ? [1] : []

    content {
      enabled = each.value.enable.retention_policy
      days    = try(each.value.retention_in_days, 90)
    }
  }

  identity {
    type = try(each.value.encryption.enable, false) == true ? "UserAssigned" : "SystemAssigned"

    identity_ids = try([azurerm_user_assigned_identity.instance_identity[each.key].id], [])
  }

  dynamic "georeplications" {
    for_each = {
      for repl in local.replications : repl.repl_key => repl
      if each.value.sku == "Premium"
    }

    content {
      location                  = georeplications.value.location
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
      regional_endpoint_enabled = georeplications.value.regional_endpoint_enabled
    }
  }

  dynamic "encryption" {
    for_each = try(each.value.encryption.enable, false) == true ? [1] : []

    content {
      enabled            = try(encryption.enable, true)
      key_vault_key_id   = each.value.encryption.kv_key_id
      identity_client_id = azurerm_user_assigned_identity.instance_identity[each.key].client_id
    }
  }
}
