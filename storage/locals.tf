locals {
  location = "southcentralus"

  resource_group_name = try(var.module_config.resource_group_name, null) == null ? resource.azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name

  mandatory_compliance_tags = {
    "Project"            = var.module_config.project
    "Environment"        = var.module_config.environment
    "CreationDate"       = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
    "SourceCodeLocation" = "https://github.bnsf.com/HY/terraform-modules-registry.git"
  }
  module_tags = merge(local.mandatory_compliance_tags, var.module_config.additional_tags)
  app         = coalesce(var.module_config.app, "")
  containers  = try(var.module_config.containers, null) == null ? [] : var.module_config.containers
}
