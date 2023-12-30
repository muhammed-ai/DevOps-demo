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