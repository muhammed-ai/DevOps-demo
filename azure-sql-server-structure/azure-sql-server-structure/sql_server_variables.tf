variable "sql_server_base" {
  type = map(object({
    name                = optional(string)
    location            = string
    resource_group_name = optional(string)
    version             = string
    administrator_login             = string
    administrator_login_password    = optional(string)
    attach_sql_database = optional(map(object({
      name                = optional(string)
      location            = string
      server_name         = optional(string)
      version             = string
      administrator_login = string
    })))
  }))
  description = "sql server configuration details."
  sensitive   = false
  nullable    = true
}
