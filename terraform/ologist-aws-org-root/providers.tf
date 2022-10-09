provider "aws" {
  region = var.loc.region

  default_tags {
    tags = module.shared.tags
  }
}

provider "template" {
}
