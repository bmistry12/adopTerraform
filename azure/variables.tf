### Reqired Azure/ADOPC Config
variable "vm_size" {
  type    = "string"
  default = "Standard_D2s_v3"
}

### Secrets- store in a secret.tfvars file
variable "subscription_id" {
  type    = "string"
  default = " "
}

variable "tenant_id" {
  type    = "string"
  default = " "
}

# Only required if using a Service Principle (recommended method)
variable "client_id" {
  type    = "string"
  default = " "
}

variable "client_secret" {
  type    = "string"
  default = " "
}

# ADOP credentials
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

# Optional Variables to Modify
variable "private_ip" {
  type = "string"  
  default = "172.31.64.10"
}

variable "subnet_cidr" {
  type = "string"
  default = "172.31.64.0/28"
}

variable "virtual_network_cidr" {
  type = "list"
  default = ["172.31.0.0/16"]
}

variable "EIP_location" {
  type = "string"
  default = "West Europe"
}