variable "module_config" {
  type = object({
    name                        = optional(string)
    resource_group_name         = string
    location                    = string
    environment                 = optional(string)
    project                     = optional(string)
    tags                        = optional(string)
  })
  
}

variable "account_tier" {
  description = "Defines the Tier to use for this Storage Account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created."
  default     = "Standard"
}
variable "account_replication_type" {
  description = "Defines the type of replication to use for this Storage Account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`."
  default     = "LRS"
}
variable "access_tier" {
  description = "Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`."
  default     = "Hot"
}

variable "container_access_type" {
  description = "Specifies the access type for the share. `Container` will provide a full container, while `Blob` will provide a full blob. Note that Shared Access Signatures"
  default =  "private"
}
