# -----------------------------------------------------------------------------
# tf-atom-kms-key-policy-aws
#
# Single-resource atom: one aws_kms_key_policy, gated by the standard `enabled`
# flag from context.tf. This resource has no tags.
# -----------------------------------------------------------------------------

resource "aws_kms_key_policy" "this" {
  count = local.enabled ? 1 : 0

  key_id                             = var.key_id
  policy                             = var.policy
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
}
