provider "aws" {
  region = "${var.aws_region}"

  # aws access/secret key
  shared_credentials_file = "${var.aws_account_credentials_path}"
  profile                 = "${var.aws_profile_name}"
}
