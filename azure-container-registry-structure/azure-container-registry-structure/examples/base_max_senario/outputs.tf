output "out" {
  value       = local.aggregate_output
  description = "The output from azurerm_container_registry"
  sensitive   = false
}