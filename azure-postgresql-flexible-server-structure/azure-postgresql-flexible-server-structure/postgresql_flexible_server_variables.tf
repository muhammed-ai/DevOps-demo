variable "postgresql_flexible_server_base" {
  type = map(object({
    name                      = optional(string)
    location                  = string
    resource_group_name       = optional(string)
    version                   = string
    administrator_login       = string
    administrator_password    = optional(string)
    sku_name                  = optional(string)
    backup_retention_days     = optional(number)
    delegate_subnet_id       = optional(string)
    private_dns_zone_id       = optional(string)
    storage_mb                = optional(number)
    geo_redundant_backup_enable = optional(number)
    source_server_id           = optional(string)
    maintenance_window          = optional(map(object({
      day_of_week              = string
      start_hour               = number
      duration                 = number
    })))
    high_availability_enabled   = optional(object({
      enabled                   = bool
      availability_zone         = string  
      mode                      = string
      }))
    #Authentication block
    authentication                  = optional(object({
      active_directory_auth_enable  = bool
      password_auth_enabled         = bool
      tenant_id                     = string //active directory_auth must be set to true first
    }))
      

    attach_postgresql_database = optional(map(object({
      name                     = optional(string)
      server_id                = optional(string)
    })))

  }))
  description = "postgresql server configuration details."
  sensitive   = false
  nullable    = true
}