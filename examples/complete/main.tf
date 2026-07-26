# -----------------------------------------------------------------------------
# Complete example: tf-atom-kms-key-policy-aws
# -----------------------------------------------------------------------------

provider "aws" {
  region = "eu-west-1"
}

module "kms_key_policy" {
  source = "../../"

  namespace   = "eg"
  environment = "euw1"
  stage       = "app"
  name        = "data"

  key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnableIAMUserPermissions"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::123456789012:root" }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })
}

output "policy_id" {
  description = "Id of the KMS key policy."
  value       = module.kms_key_policy.id
}
