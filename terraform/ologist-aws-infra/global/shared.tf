module "shared" {
  source = "../../_modules/shared"

  id  = var.id
  loc = var.loc
}

module "shared_useast1" {
  source = "../../_modules/shared"

  id  = var.id
  loc = merge(var.loc, { region = "us-east-1" })
}
