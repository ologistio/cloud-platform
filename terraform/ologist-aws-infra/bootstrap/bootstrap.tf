module "bootstrap" {
  source = "trussworks/bootstrap/aws"

  region        = "eu-west-1"
  account_alias = "ologist-aws-infra"
}
