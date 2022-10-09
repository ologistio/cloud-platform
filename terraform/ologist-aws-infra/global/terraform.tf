terraform {
  required_version = "~> 1.0"

  backend "s3" {
    acl    = "private"
    region = "eu-west-1"
  }

  default_tags {
    tags = module.shared.tags
  }
}
