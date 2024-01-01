variable "sql_server_attach_sql_database" {
  type = map(object({
    name                  = optional(string)
    location              = string
    resource_group_name   = optional(string)
    server_name           = string
    version               = string
    administrator_login            = string
  }))
    description = "sql server configuration details."
    sensitive   = false
    nullable    = true
}