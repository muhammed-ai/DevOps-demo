variable "module_config" {
  description = "Base configuration for virtual network"
  type = object({
    # For creating the virtual network
    network_config = object({
      cidr    = string
      subnets = list(object({
        name        = string
        cidr        = string
        delegations = optional(list(object({
          name         = string
          service_name = string
          actions      = list(string)
        })))
      })
    )})

    # For naming conventions
    project     = string
    environment = string

    # For governance purpose
    additional_tags = map(string)
  })

  # Validation for cidr_range
  validation {
    condition     = can(cidrsubnet(var.module_config.network_config.cidr, 0, 0))
    error_message = "The cidr value must be a valid CIDR notation."
  }

  # Validation for network_config
  validation {
    condition     = length(var.module_config.network_config) > 0
    error_message = "The network_config value must not be empty."
  }

  # Validation for project
  validation {
    condition     = length(var.module_config.project) > 0
    error_message = "The project value must not be empty."
  }

  # Validation for environment
  validation {
    condition     = contains(["dev", "test", "nonprod", "prod"], var.module_config.environment)
    error_message = "The environment value must be one of dev, test, nonprod or prod."
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
