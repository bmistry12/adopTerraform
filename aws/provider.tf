provider "aws" {
  region = "eu-west-1"

  # aws access/secret key
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform-workshop"
}
