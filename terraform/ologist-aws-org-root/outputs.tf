# We need to have outputs for all these accounts because we need to
# know the account numbers when we're setting up things in other
# accounts.
output "aws_organizations_account_ologist_org_root_id" {
  description = "Account number for the ologist-org-root account"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_organizations_account_ologist_id_id" {
  description = "Account number for the ologist-id account"
  value       = aws_organizations_account.ologist_id.id
}

output "aws_organizations_account_ologist_infra_id" {
  description = "Account number for the ologist-infra account"
  value       = aws_organizations_account.ologist_infra.id
}
