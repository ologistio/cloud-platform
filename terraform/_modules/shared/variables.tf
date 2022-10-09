variable "id" {
  description = "Identification object"
  type = object({
    group               = string
    cost_centre         = string
    core_infrastructure = string
    application         = string
    component           = string
    stack               = string
  })

  validation {
    condition     = var.id.group != null && var.id.group != ""
    error_message = "Group name must be supplied."
  }

  validation {
    condition     = var.id.cost_centre != null && var.id.cost_centre != ""
    error_message = "Cost centre must be supplied."
  }

  validation {
    condition     = contains(["true", "false"], var.id.core_infrastructure)
    error_message = "Core Infrastructure flag must be supplied. Valid values are `true` and `false`."
  }

  validation {
    condition     = var.id.application != null && var.id.application != ""
    error_message = "Application name must be supplied."
  }

  validation {
    condition     = (var.id.component == null) || (var.id.component != "")
    error_message = "If supplied, the component name must not be an empty string."
  }

  validation {
    condition     = (var.id.stack == null) || (var.id.stack != "")
    error_message = "If supplied, the stack name must not be an empty string."
  }
}

variable "loc" {
  description = "Location object"
  type = object({
    environment = string
  })

  validation {
    condition     = contains(["root", "sandbox"], var.loc.environment)
    error_message = "Environment name must be one of root or sandbox."
  }
}

variable "additional" {
  description = "Additional tags to add to the map of all tags, after adding organisation prefix"
  type        = map(string)
  default     = {}
}

variable "additional_raw" {
  description = "Additional tags to add to the map of all tags, without adding any prefix"
  type        = map(string)
  default     = {}
}
