provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  # If using Service Principle
  #   client_id = "${var.client_id}"
  #   client_secret = "${var.client_secret}"
}

resource "azurerm_resource_group" "adopResourceGroup" {
  name     = "adopc"
  location = "West Europe"
}
