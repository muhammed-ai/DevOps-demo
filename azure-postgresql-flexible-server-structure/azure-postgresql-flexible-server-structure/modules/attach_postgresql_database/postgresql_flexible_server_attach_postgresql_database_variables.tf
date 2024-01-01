variable "postgresql_flexible_server_attach_postgresql_database" {
  type = map(object({
    name        = optional(string)
    server_id   = string
  }))
    description = "postgresql server database configuration details."
    sensitive   = false
    nullable    = true
}
