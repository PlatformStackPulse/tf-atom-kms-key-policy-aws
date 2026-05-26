variable "key_id" {
  description = "ID of the KMS key to attach the policy to"
  type        = string
  validation {
    condition     = length(var.key_id) > 0
    error_message = "key_id must not be empty."
  }
}

variable "policy" {
  description = "JSON-encoded key policy document"
  type        = string
  validation {
    condition     = can(jsondecode(var.policy))
    error_message = "policy must be valid JSON."
  }
}
