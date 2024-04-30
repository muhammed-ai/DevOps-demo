variable "module_config" {
  description = "Base configuration for azure container registry module."
  type = object({
    resource_group_name = optional(string)
    name        = optional(string)
    # For naming
    project     = string
    environment = string

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
    condition     = contains(["dev", "qa", "trial", "staging", "test", "nonprod", "prod"], var.module_config.environment)
    error_message = "The environment value must be one of dev, qa, trial, staging, test, nonprod, prod"
  }

  # Validation for project
  validation {
    condition     = length(var.module_config.project) > 0
    error_message = "The project value must not be empty."
  }
}