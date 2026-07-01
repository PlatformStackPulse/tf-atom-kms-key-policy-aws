output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "Disambiguated ID (tf-label generated identifier), e.g. \"namespace-stage-name\"."
  value       = module.this.id
}
