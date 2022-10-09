provider "aws" {
  version = "~> 4.0"
  region  = var.loc.region
}

provider "template" {
  version = "~> 2.1"
}
