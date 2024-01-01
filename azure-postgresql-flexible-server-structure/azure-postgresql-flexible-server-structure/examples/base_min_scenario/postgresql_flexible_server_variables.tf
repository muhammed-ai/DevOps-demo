variable postgresql_flexible_server_base {
    type =  map(object({
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
    
      # maintenance_window      = string
    }))
    }