variable "module_config" {
  description = "A map of VM configuration parameters"
  type = object({
    # For naming conventions
    project     = string
    environment = string

    k8s_config = object({
      # For k8s configuration
      name_prefix    = string
      node_count     = number
      min_node_count = number
      max_node_count = number
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

  # Validation for environment
  validation {
    condition     = contains(["dev", "test", "prod", "nonprod"], var.module_config.environment)
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
