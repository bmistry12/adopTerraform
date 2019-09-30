### Required AWS config - change as see fit
variable "aws_account_credentials_path" {
  type = "string"
  default = "~/.aws/credentials"
}

variable "aws_region" {
  type = "string"
  default = "eu-west-1"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = "string"
  default = "10.0.0.0/24"
}

variable "ami_id" {
  type    = "string"
  default = "ami-7abd0209"
}

variable "volume_type" {
  type    = "string"
  default = "gp2"
}

variable "instance_type" {
  type = "string"
  default = "m4.xlarge"
}

# Keeping access open to all is not very secure!
variable "inbound_accessible_ips" {
  type = "list"
  default = ["0.0.0.0/0"]
}

### Required AWS/ADOP Secrets
# Add these into a secret.tfvars file
variable "aws_profile_name" {
  type = "string"
  default = " "
}

variable "adop_username" {
  type    = "string"
  default = " "
}

variable "adop_password" {
  type    = "string"
  default = " "
}

### Use your own key pair - values will go in secret.tfvars
# Name of file containing private key
variable "aws_key_name" {
  type = "string"
  default = " "
}

# Public Key
variable "public_key" {
  type = "string"
  default = " "
}

### Customising names of resources and tags
variable "iam_role_name" {
  type = "string"
  default = "adopIAMRole"
}

