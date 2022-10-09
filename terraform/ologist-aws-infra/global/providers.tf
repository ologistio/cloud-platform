provider "aws" {
  region = var.loc.region
}

# This is a special provider we use for Route53, because that service
# only exists in us-east-1. Note that we call this specifically where
# we create DNS entries.
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "template" {
}
