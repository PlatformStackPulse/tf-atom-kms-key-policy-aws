# -----------------------------------------------------------------------------
# Module-Specific Variables
#
# Note: Standard labeling variables (enabled, namespace, tenant, environment,
# stage, name, delimiter, attributes, tags, label_order, etc.) are provided
# by context.tf via the tf-label module.
# -----------------------------------------------------------------------------

variable "key_id" {
  description = "Id of the KMS key to attach the policy to."
  type        = string

  validation {
    condition     = length(var.key_id) > 0
    error_message = "key_id must be a non-empty string."
  }
}

variable "policy" {
  description = "JSON key policy document to attach to the KMS key."
  type        = string

  validation {
    condition     = can(jsondecode(var.policy))
    error_message = "policy must be a valid JSON document."
  }
}

variable "bypass_policy_lockout_safety_check" {
  description = "Whether to bypass the key policy lockout safety check. Setting this to true increases the risk of the KMS key becoming unmanageable."
  type        = bool
  default     = false
}
