provider "azurerm" {
  features {}
}

module "base" {
  source = "git::https://github.bnsf.com/HY/azure-common-base.git?ref=structure"
  config = var.config
}

module "naming" {
  source = "git::https://github.bnsf.com/HY/azure-common-base.git//modules/base_naming?ref=structure"
  prefix = [var.config.entity.team_name, var.config.entity.app_name, var.config.entity.env_name]
}

module "tags" {
  source  = "git::https://github.bnsf.com/HY/azure-common-base.git//modules/base_tags?ref=structure"
  config  = var.config
  runtime = var.runtime
}

module "azurerm_sql_server_example" {
  source          = "../.."
  config          = var.config
  runtime         = var.runtime 
  sql_server_base = var.sql_server_base
}

locals {
  aggregate_output = {
    sql_server : module.azurerm_sql_server_example.out
  }
}
