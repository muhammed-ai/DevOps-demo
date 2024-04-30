variable "module_config" {
  description = "A map of VM configuration parameters"
  type = object({
    # For naming conventions
    project             = string
    environment         = string
    resource_group_name = optional(string)

    vm_config = object({
      # For VM configuration
      name_prefix                = optional(string)
      name                       = optional(string)
      size                       = optional(string)
      availability_zone          = optional(string)
      admin_username             = optional(string)
      license_type               = optional(string)
      user_assigned_identity_ids = optional(list(string))
      secure_boot_enabled        = optional(bool)
      vtpm_enabled               = optional(bool)
      encryption_at_host_enabled = optional(bool)
      vm_shared_image_version = optional(object({
        name                = string
        image_name          = string
        gallery_name        = string
        resource_group_name = string
      }))
    })

    network_config = object({
      # For network configuration
      vnet_name   = string
      subnet_name = string
    })

    # For governance purpose
    additional_tags = map(string)
  })

  # Validation for vnet_name
  validation {
    condition     = length(var.module_config.network_config.vnet_name) > 0
    error_message = "The vnet_name value must not be empty."
  }

  # Validation for name
  validation {
    condition     = can(length(var.module_config.vm_config.name)) ? length(var.module_config.vm_config.name) <= 15 : var.module_config.vm_config.name == null
    error_message = "The name value must not be more than 15 characters."
  }

  # Validation for project  
  validation {
    condition     = length(var.module_config.project) > 0
    error_message = "The project value must not be empty."
  }

  # Validation for subnets
  validation {
    condition     = length(var.module_config.network_config.subnet_name) > 0
    error_message = "The network_config value must not be empty."
  }

  validation {
    condition     = contains(["sandbox", "dev", "test", "trial", "staging", "qa", "prod", "nonprod"], var.module_config.environment)
    error_message = "The environment value must be one of sandbox, dev, test, trial, staging, qa, prod, nonprod"
  }

  # Validation for additional_tags
  validation {
    condition = alltrue([
      for tag, value in var.module_config.additional_tags :
      length(tag) <= 256 && length(value) <= 256
    ])
    error_message = "The additional_tags keys and values must not exceed 256 characters."
  }
}
