
variable "container_registry_base" {
  type = map(object({
    name                = optional(string)
    location            = string
    resource_group_name = string
    sku                 = string
    identity_name       = optional(string)

    replications = object({
      sea = object({
        location                  = string
        zone_redundancy_enabled   = optional(bool)
        regional_endpoint_enabled = optional(bool)
      })
      eus = object({
        location                  = string
        zone_redundancy_enabled   = optional(bool)
        regional_endpoint_enabled = optional(bool)
      })
    })
  }))
}
