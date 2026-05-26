resource "aws_kms_key_policy" "this" {
  count = module.this.enabled ? 1 : 0

  key_id = var.key_id
  policy = var.policy
}
