variable "aws_vpc" {
  type    = "string"
  default = "vpc-e7c6aa80"
}

variable "ami_id" {
  type    = "string"
  default = "ami-7abd0209"
}

variable "volume_type" {
  type    = "string"
  default = "gp2"
}

variable "adop_username" {
  type    = "string"
  default = " "
}

variable "adop_password" {
  type    = "string"
  default = " "
}

# Name of pem file containing pubkey
variable "key_name" {
  type    = "string"
  default = " "
}
