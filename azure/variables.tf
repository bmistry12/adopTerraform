variable "subscription_id" {
  type    = "string"
  default = " "
}

variable "tenant_id" {
  type    = "string"
  default = " "
}

# For Service Principle
variable "client_id" {
  type    = "string"
  default = " "
}

variable "client_secret" {
  type    = "string"
  default = ""
}

variable "vm_size" {
  type    = "string"
  default = "Standard_D2s_v3"
}

variable "adop_username" {
  type    = "string"
  default = " "
}

variable "adop_password" {
  type    = "string"
  default = " "
}

variable "public_key" {
  type    = "string"
  default = " "
}

