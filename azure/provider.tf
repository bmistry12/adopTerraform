provider "azurerm" {
  # If using Service Principle
  client_id     = "${var.client_id}"
  client_secret = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "adopResourceGroup" {
  name     = "adopc"
  location = "West Europe"
}
