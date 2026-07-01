# Unit Tests for tf-atom-kms-key-policy-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:  terraform test -test-directory=tests/unit
#
# Assertions target plan-KNOWN values only (the tf-label id string and the
# enabled pass-through). Computed KMS ARNs/IDs are unknown under a mock
# provider and must not be asserted on.

mock_provider "aws" {}

variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
}

# ---------------------------------------------------------------------------
# Test: module composes the tf-label identifier when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default."
  }

  assert {
    condition     = output.id == "eg-test-thing"
    error_message = "tf-label id should be composed as 'eg-test-thing' from namespace/stage/name."
  }
}

# ---------------------------------------------------------------------------
# Test: disabling the module short-circuits creation
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Setting enabled=false must disable the module."
  }
}
