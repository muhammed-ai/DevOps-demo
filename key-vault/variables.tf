variable "module_config" {
  description = "Base configuration for the Key Vault module."
  type = object({

    #resource_group
    resource_group_name = optional(string)
    
    # If the key vault name is not provided, it will be generated using the naming convention
    name = optional(string)

    # For access policy, object ID of a user, service principal or security group
    access_ids = map(string)

    # For key vault configuration overrides
    key_vault_config_overrides = optional(map(string))

    # For network configuration to enable access from specific subnets
    network_config = object({
      subnet_names = list(string)
      vnet_name    = string
      vnet_rg      = string
    })

    # For naming
    project     = string
    environment = string

    # For governance
    additional_tags = map(string)
  })

  # Validation for object_ids
  validation {
    condition     = length(var.module_config.access_ids) > 0
    error_message = "The access_ids value is a mandatory parameters and must be passed."
  }

  # Validation for vnet_name
  validation {
    condition     = length(var.module_config.network_config.vnet_name) > 0
    error_message = "The vnet_name value must not be empty."
  }
  validation {
    condition     = length(var.module_config.network_config.vnet_rg) > 0
    error_message = "The vnet_rg value must not be empty."
  }
  validation {
    condition     = length(var.module_config.network_config.subnet_names) > 0
    error_message = "The subnet_names value must not be empty."
  }

  # Validation for additional_tags
  validation {
    condition = alltrue([
      for tag, value in var.module_config.additional_tags :
      length(tag) <= 256 && length(value) <= 256
    ])
    error_message = "The additional_tags keys and values must not exceed 256 characters."
  }

  # Validation for environment
  validation {
    condition     = contains(["dev", "qa", "trial", "staging", "test", "nonprod", "prod"], var.module_config.environment)
    error_message = "The environment value must be one of dev, qa, trial, staging, test, nonprod, prod"
  }

  # Validation for project
  validation {
    condition     = length(var.module_config.project) > 0
    error_message = "The project value must not be empty."
  }
}
