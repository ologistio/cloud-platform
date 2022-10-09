variable "vcs" {
  description = "Values for recommended version control tags"
  type = object({
    repo    = string
    version = string
    commit  = string
  })

  validation {
    // todo - improve validation to enforce a particular repo URL format (https) ?
    condition     = var.vcs.repo != null && var.vcs.repo != ""
    error_message = "VCS repository URL must be supplied."
  }

  validation {
    // todo - improve validation to identify allowed version strings - common branch names or numeric tags ?
    condition     = var.vcs.version != null && var.vcs.version != ""
    error_message = "VCS version must be supplied."
  }

  validation {
    // todo - improve validation to enforce long commit ID format ?
    condition     = var.vcs.commit != null && var.vcs.commit != ""
    error_message = "VCS commit ID must be supplied."
  }
}

variable "deployment_type" {
  description = "Deployment type"
  type        = string

  validation {
    condition     = var.deployment_type != null && contains(["Automatic", "Manual"], var.deployment_type)
    error_message = "Deployment type must be Automatic or Manual."
  }
}

output "vcs" {
  description = "Validated VCS object"
  value       = var.vcs
}

output "deployment_type" {
  description = "Validated deployment type"
  value       = var.deployment_type
}
