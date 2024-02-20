
locals {
  location               = "southcentralus"
  resource_group_name   = "ibrahim-demoRG"

mandatory_compliance_tags = {
    "Project"            = var.module_config.project
    "Environment"        = var.module_config.environment
    "CreationDate"       = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
    "SourceCodeLocation" = "https://github.bnsf.com/HY/terraform-modules-registry.git"
  }
  module_tags = merge(local.mandatory_compliance_tags, var.module_config.additional_tags)
}
