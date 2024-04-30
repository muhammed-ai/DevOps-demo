locals {
  # Global defaults that cannot be overwiitten by the module caller
  default_location = "southcentralus"

  cloud_foundation_defaults = {
    resource_group_name = "cloudops-foundation-rg"
    gallery_name        = "bnsfecpfndnonprodgallery"
  }

  name_prefix = var.module_config.vm_config.name_prefix != null ? substr("${var.module_config.vm_config.name_prefix}", 0, 7) : null

  # https://wiki.bnsf.com/display/BW/Tagging
  mandatory_compliance_tags = {
    "Project"            = var.module_config.project
    "Environment"        = var.module_config.environment
    "CreationDate"       = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
    "SourceCodeLocation" = "https://github.bnsf.com/HY/terraform-modules-registry.git"
  }
  module_tags = merge(local.mandatory_compliance_tags, var.module_config.additional_tags)

  # Default network configuration that can be overridden by the module caller
  network_config_defaults = {
    vnet_rg_name = "NetworkRG"
  }

  # Default VM configuration that can be overridden by the module caller.
  vm_config_defaults = {
    size                       = "Standard_D4s_v3"
    availability_zone          = "2"
    admin_username             = "cloudadmin"
    license_type               = "Windows_Server"
    secure_boot_enabled        = true
    vtpm_enabled               = true
    encryption_at_host_enabled = true
    vm_shared_image_version = {
      name                = "0.0.1"
      image_name          = "bnsf_server2022"
      gallery_name        = local.cloud_foundation_defaults.gallery_name
      resource_group_name = local.cloud_foundation_defaults.resource_group_name
    }
  }

  # Using this mechanism will allow the default settings to be overwriten by the user.
  network_config_overrides = try(var.module_config.network_config, {})

  # Merge the default network configuration with the module caller's network configuration
  network_config = merge(
    local.network_config_defaults,
    { for k, v in local.network_config_overrides : k => v if v != null }
  )

  # Using this mechanism will allow the default settings to be overwriten by the user.
  vm_config_overrides = try(var.module_config.vm_config, {})

  # Merge the default VM configuration with the module caller's VM configuration
  vm_config = merge(
    local.vm_config_defaults,
    { for k, v in local.vm_config_overrides : k => v if v != null }
  )
}

resource "terraform_data" "check_variables" {
  lifecycle {
    precondition {
      condition     = contains(["Standard_B1s", "Standard_D1_v2", "Standard_D2_v4", "Standard_D2_v5", "Standard_D3_v2", "Standard_D4_v3", "Standard_D4_v4", "Standard_D4_v5", "Standard_D4s_v3", "Standard_D4s_v4", "Standard_D4s_v5", "Standard_D2s_v3", "Standard_D16s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_E16s_v3", "Standard_E2s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_M208ms_v2", "Standard_M208s_v2", "Standard_M64s", "Standard_M64ms"], try(local.vm_config.size, ""))
      error_message = "size invalid: Must be one of ['Standard_B1s', 'Standard_D1_v2', 'Standard_D2_v4', 'Standard_D2_v5', 'Standard_D3_v2', 'Standard_D4_v3', 'Standard_D4_v4', 'Standard_D4_v5','Standard_D4s_v3', 'Standard_D4s_v4','Standard_D4s_v5','Standard_D2s_v3', 'Standard_D16s_v3', 'Standard_D4s_v3', 'Standard_D8s_v3', 'Standard_E16s_v3', 'Standard_E2s_v3', 'Standard_E4s_v3', 'Standard_E8s_v3', 'Standard_M208ms_v2', 'Standard_M208s_v2', 'Standard_M64s', 'Standard_M64ms']"
    }
    precondition {
      condition     = contains(["1", "2", "3"], try(local.vm_config.availability_zone, ""))
      error_message = "availability_zone invalid: Must be one of ['1', '2', '3']"
    }
    precondition {
      condition     = contains(["cloudadmin"], try(local.vm_config.admin_username, ""))
      error_message = "admin_username invalid: Must be one of ['cloudadmin']"
    }
  }
}
