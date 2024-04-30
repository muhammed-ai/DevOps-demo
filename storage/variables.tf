variable "module_config" {
  type = object({
    # Mandatory parameters to use for naming convention
    project     = string
    environment = string
    app         = optional(string)

    # If the storage account name is not provided, it will be generated using the naming convention
    name = optional(string)

    # Optional parameters to use for resource creation
    resource_group_name = optional(string)

    # Containes that needs to be created inside the storage account
    containers          = optional(list(string))

    # Mandatory parameters to use for resource creation
    network_config = object({
      subnet_names = list(string)
      vnet_name    = string
      vnet_rg      = string
    })

    additional_tags = map(string)
  })

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
    condition     = contains(["dev", "test", "nonprod", "prod"], var.module_config.environment)
    error_message = "The environment value must be one of dev, test, nonprod or prod."
  }

  # Validation for project
  validation {
    condition     = length(var.module_config.project) > 0
    error_message = "The project value must not be empty."
  }
}
