mock_provider "aws" {}

# Standard tf-label inputs shared by every run block below.
variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
  key_id    = "1234abcd-12ab-34cd-56ef-1234567890ab"
  policy    = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"Enable IAM User Permissions\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::123456789012:root\"},\"Action\":\"kms:*\",\"Resource\":\"*\"}]}"
}

run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled = true when enabled is left at its default."
  }

  assert {
    condition     = length(aws_kms_key_policy.this) == 1
    error_message = "Exactly one aws_kms_key_policy should be planned when enabled."
  }

  assert {
    condition     = aws_kms_key_policy.this[0].key_id == "1234abcd-12ab-34cd-56ef-1234567890ab"
    error_message = "key_id should be passed through to the resource."
  }
}

run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when enabled = false is passed."
  }

  assert {
    condition     = length(aws_kms_key_policy.this) == 0
    error_message = "No aws_kms_key_policy should be planned when disabled."
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled."
  }
}
