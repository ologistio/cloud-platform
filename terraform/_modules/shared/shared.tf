locals {
  org_name   = "ologist"
  email_base = "cloud-platform"
  dns_name   = "ologist.io"

  accounts = {
    aws = {
      aws-org-root = {
        id    = "165133900345",
        name  = "${local.org_name}-aws-org-root",
        email = "${email_base}+aws-org-root@${local.dns_name}"
      },
      aws-infra = {
        id    = "203143273747",
        name  = "${local.org_name}-aws-infra",
        email = "${email_base}+aws-infra@${local.dns_name}"
      },
      aws-id = {
        id    = "451929074005"
        name  = "${local.org_name}-aws-id",
        email = "${email_base}+aws-id@${local.dns_name}"
      }
    }
  }

  local_prefix  = "${var.id.application}-${var.id.component}-${var.id.stack}"
  global_prefix = "${local.org_name}-${var.id.application}-${var.loc.environment}-${var.id.component}-${var.id.stack}"
}

output "org" {
  value = local.org_name
}

output "dns_root" {
  value = local.dns_root
}

output "accounts" {
  value = local.accounts
}

output "prefix" {
  output = local.local_prefix
}

output "global_prefix" {
  output = local.global_prefix
}
