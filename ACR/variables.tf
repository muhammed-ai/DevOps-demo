variable "resource_group_name" {
  default =     "DemoRG-1"
  description = "RG name in Azure"
}
variable "location" {
  default = "Central US"
  description = "Resources location in Azure"
}

variable "acr_name" {
  default = "test01acr01"
  description = "ACR name"
}

