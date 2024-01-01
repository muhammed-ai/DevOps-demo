output "out" {
  value       = local.aggregate_output
  description = "The output from azuure sql server"
  sensitive   = false
}