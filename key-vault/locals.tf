locals {
  location = "southcentralus"

  # These are audit storage accounts that belongs to foundation environment to track all the audit activities.
  storage_account_rg = "cloudops-foundation-rg"
  storage_account_name = {
    nonprod = "bnsfecpfndnonprodaudit"
    prod    = "bnsfecpfndprodaudit"
  }
  
  mandatory_compliance_tags = {
    "Project"            = var.module_config.project
    "Environment"        = var.module_config.environment
    "CreationDate"       = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
    "SourceCodeLocation" = "https://github.bnsf.com/HY/terraform-modules-registry.git"
  }

  module_tags = merge(local.mandatory_compliance_tags, var.module_config.additional_tags)

  # Defaults as per the UPD however based on the use cases, it will be allowed to be overridden.
  key_vault_defaults = {
    soft_delete_retention_days = 7
    purge_protection_enabled   = true
    soft_delete_enabled        = true
    sku_name                   = "standard"
    disk_encryption            = true
    prevent_destroy            = true
  }

  # Check if the there are any overrides specified. If not, then use the defaults.
  key_vault_config_overrides = lookup(var.module_config, "key_vault_config_overrides", {}) != {} ? var.module_config.key_vault_config_overrides : {}
  key_vault_config           = merge(local.key_vault_defaults, local.key_vault_config_overrides)
}
