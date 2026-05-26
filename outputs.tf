output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "key_id" {
  description = "ID of the KMS key the policy is attached to"
  value       = try(aws_kms_key_policy.this[0].key_id, null)
}
