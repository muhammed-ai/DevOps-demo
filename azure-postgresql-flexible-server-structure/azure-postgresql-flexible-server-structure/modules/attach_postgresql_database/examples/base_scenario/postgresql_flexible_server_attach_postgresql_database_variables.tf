variable postgresql_flexible_server_attach_postgresql_database {
type = map(object({
      name                = optional(string)
      location            = string
      server_id           = string
      resource_group_name = optional(string)
      version             = string
      administrator_login = string
    }))
}