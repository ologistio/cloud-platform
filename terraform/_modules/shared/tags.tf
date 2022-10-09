#
# Version Control Tagging
#

data "external" "vcs" {
  program = ["${path.module}/scripts/vcs.sh"]
}

locals {

  vcs = {
    repo : data.external.vcs.result.repo,
    version : data.external.vcs.result.version,
    commit : data.external.vcs.result.commit
  }
}

#
# CI Tagging
#

data "external" "ci" {
  program = ["${path.module}/scripts/ci.sh"]
}

locals {
  deployment_type = data.external.ci.result.ci == "true" ? "Automatic" : "Manual"
}

#
# Tags
#

locals {

  prefix = "${local.org_name}:"

  mandatory = {
    environment         = var.loc.environment
    application         = var.id.application
    owner-email         = local.accounts[var.id.application].email
    cost-centre         = var.id.cost_centre
    group               = var.id.group
    deployment-type     = module.validate.deployment_type
    core-infrastructure = var.id.core_infrastructure
  }

  recommended_vcs = {
    repo    = module.validate.vcs.repo
    version = module.validate.vcs.version
    commit  = module.validate.vcs.commit
  }

  recommended = {
    component = var.id.component
    stack     = var.id.stack
  }

  mandatory_prefixed       = { for k, v in local.mandatory : "${local.prefix}${k}" => v }
  recommended_vcs_prefixed = { for k, v in local.recommended_vcs : "${local.prefix}vcs:${k}" => v }
  recommended_prefixed     = { for k, v in local.recommended : "${local.prefix}${k}" => v }
  additional_prefixed      = { for k, v in var.additional : "${local.prefix}${k}" => v }

  all_output = merge(
    local.mandatory_prefixed,
    local.recommended_vcs_prefixed,
    local.recommended_prefixed,
    local.additional_prefixed,
    var.additional_raw
  )
}

#
# Validation
#

module "validate" {
  source = "./validate"

  vcs             = local.vcs
  deployment_type = local.deployment_type
}

#
# Outputs
#

output "tags" {
  description = "Map of all tags, including mandatory, recommended and user-supplied additional tags"
  value       = local.all_output
}
