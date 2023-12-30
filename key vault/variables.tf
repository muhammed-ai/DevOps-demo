variable "resource_group" {
    description = "The name of the resource group in which to create the virtual network."
    default = "DemoRG-1"
}
variable "location" {
    default = "Central US"
}
variable "vnet" {
    default = "vnet1"
}
variable "subnet" {
    default = "subnet1"
}
variable "tenant_id" {
    default = "24591a9c-0d42-4f10-800a-291df9690154"
}


