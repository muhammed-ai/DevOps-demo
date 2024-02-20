variable "module_config" {
  type = object({
    #naming convention
    environment       = optional(string)
    project           = optional(string)
    resource_group_name =  string
    //
    additional_tags   = map(string)
    subnet_id         = string
    #subnet_id         = list(string)
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

#   # Validation for subnets
#   validation {
#     condition     = length(var.module_config.subnets) > 0
#     error_message = "The subnets value must not be empty."
#   }
 }