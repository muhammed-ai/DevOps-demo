    variable postgresql_flexible_server_base {
      type = map(object({
      name                = optional(string)
      location            = string
      resource_group_name = optional(string)
      version             = string
      administrator_login        = string
      administrator_password     = optional(string)
      attach_postgresql_database = optional(map(object({
        name        = optional(string)
        server_id   = string
      })))
    }))
    }