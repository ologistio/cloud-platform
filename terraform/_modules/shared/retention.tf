locals {
  retention_rules = {
    logs = 30
  }
}

output "retention" {
  value = local.retention_rules
}
