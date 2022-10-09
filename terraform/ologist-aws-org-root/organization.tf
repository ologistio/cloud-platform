#
# AWS Organizations
#

resource "aws_organizations_organization" "main" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}

#
# Primary organizations OU
#

# This OU will contain all our useful accounts and allows us to implement
# organization-wide policies easily.
resource "aws_organizations_organizational_unit" "main" {
  name      = var.org_name
  parent_id = aws_organizations_organization.main.roots[0].id
}

#
# Suspended organization OU
#

# This OU is for locking down accounts we believe are compromised or which
# should not contain any actual resources (like GovCloud placeholders).
resource "aws_organizations_organizational_unit" "suspended" {
  name      = "suspended"
  parent_id = aws_organizations_organization.main.roots[0].id
}

module "aws_ou_scp_main" {
  source = "trussworks/ou-scp/aws"
  target = aws_organizations_organizational_unit.main.id

  # don't allow all accounts to be able to leave the org
  deny_leaving_orgs = true
  # # applies to accounts that are not managing IAM users
  # deny_creating_iam_users       = true
  # # don't allow deleting KMS keys
  # deny_deleting_kms_keys        = true
  # # don't allow deleting Route53 zones
  # deny_deleting_route53_zones   = true
  # # don't allow deleting CloudWatch logs
  # deny_deleting_cloudwatch_logs = true
  # don't allow access to the root user
  deny_root_account = true

  # protect_s3_buckets            = true
  # # protect terraform statefile bucket
  # protect_s3_bucket_resources   = [
  #   "arn:aws:s3:::prod-terraform-state-us-west-2",
  #   "arn:aws:s3:::prod-terraform-state-us-west-2/*"
  # ]

  # # don't allow public access to bucket
  # deny_s3_buckets_public_access = true
  # deny_s3_bucket_public_access_resources = [
  #   "arn:aws:s3:::log-delivery-august-2020"
  # ]

  # protect_iam_roles             = true
  # # - protect OrganizationAccountAccessRole
  # protect_iam_role_resources     = [
  #   "arn:aws:iam::*:role/OrganizationAccountAccessRole"
  # ]

  # # restrict region-specific operations to us-west-2
  # limit_regions                 = true
  # # - restrict region-specific operations to us-west-2
  # allowed_regions               = ["us-west-2"]

  # require s3 objects be encrypted
  require_s3_encryption = true

  # SCP policy tags
  tags = {
    managed_by = "terraform"
  }
}

module "aws_ou_scp_suspended" {
  source = "trussworks/ou-scp/aws"
  target = aws_organizations_organizational_unit.suspended

  # don't allow any access at all
  deny_all = true
}

#
# AWS Organization Accounts
#

resource "aws_organizations_account" "ologist_id" {
  name      = format("%s-id", var.org_name)
  email     = format("%s+id@%s", var.org_email_alias, var.org_email_domain)
  parent_id = aws_organizations_organizational_unit.main.id

  # We allow IAM users to access billing from the id account so that we
  # can give delivery/project managers access to billing data without
  # giving them full access to the org-root account.
  iam_user_access_to_billing = "ALLOW"

  tags = {
    Automation = "Terraform"
  }
}

resource "aws_organizations_account" "ologist_infra" {
  name      = format("%s-infra", var.org_name)
  email     = format("%s+infra@%s", var.org_email_alias, var.org_email_domain)
  parent_id = aws_organizations_organizational_unit.main.id

  iam_user_access_to_billing = "DENY"

  tags = {
    Automation = "Terraform"
  }
}
