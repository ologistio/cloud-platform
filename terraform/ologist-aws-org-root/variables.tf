variable "logging_bucket" {
  description = "S3 bucket for AWS logs"
  type        = string
  default     = "ologist-org-root-aws-logs"
}

variable "org_email_alias" {
  description = "Email alias for AWS email"
  type        = string
  default     = "ologist-infra"
}

variable "org_email_domain" {
  description = "Email domain for AWS email"
  type        = string
  default     = "truss.works"
}

variable "org_name" {
  description = "AWS Organization name"
  type        = string
  default     = "ologist"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}
