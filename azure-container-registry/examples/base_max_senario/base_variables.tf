variable "config" {
  type = object({

    entity = object({
      team_name = string
      app_name  = string
      env_name  = string
    })

    client = object({
      subscription_id = string
      tenant_id       = string
    })

    tags = optional(object({
      optional = optional(object({
        cost_center     = optional(string)
        project_name    = optional(string)
        department_name = optional(string)
        owner           = optional(string)
      }))
      extra = optional(map(string))
    }))
  })
}

variable "runtime" {
  type = object({
    archetype_version = optional(string, "Unknown")
    instance_version  = optional(string, "Unknown")
  })
  default = {
    archetype_version = "Unknown"
    instance_version  = "Unknown"
  }
}