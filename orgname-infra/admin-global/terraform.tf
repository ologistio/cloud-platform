terraform {
  required_version = "~> 1.0"

  backend "s3" {
    bucket         = "orgname-infra-terraform-state-us-west-2"
    key            = "admin-global/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "us-west-2"
    encrypt        = "true"
  }
}
