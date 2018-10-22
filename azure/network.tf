resource "azurerm_virtual_network" "adopVirtualNetwork" {
  name                = "adopVirtualNetwork"
  address_space       = ["172.31.0.0/16"]
  location            = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name = "${azurerm_resource_group.adopResourceGroup.name}"
}

resource "azurerm_subnet" "adopSubnet" {
  name                 = "adopSubnet"
  resource_group_name  = "${azurerm_resource_group.adopResourceGroup.name}"
  virtual_network_name = "${azurerm_virtual_network.adopVirtualNetwork.name}"
  address_prefix       = "172.31.64.0/28"
}

resource "azurerm_network_security_group" "adopSecurityGroup" {
  name                = "adopSecurityGroup"
  location            = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name = "${azurerm_resource_group.adopResourceGroup.name}"
}

resource "azurerm_network_security_rule" "allowSSH" {
  name                        = "allowSSH"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.adopResourceGroup.name}"
  network_security_group_name = "${azurerm_network_security_group.adopSecurityGroup.name}"
}

resource "azurerm_network_security_rule" "allowHTTP" {
  name                        = "allowHTTP"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.adopResourceGroup.name}"
  network_security_group_name = "${azurerm_network_security_group.adopSecurityGroup.name}"
}

resource "azurerm_network_security_rule" "allowHTTPS" {
  name                        = "allowHTTPS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.adopResourceGroup.name}"
  network_security_group_name = "${azurerm_network_security_group.adopSecurityGroup.name}"
}

resource "azurerm_network_security_rule" "allowDockerTCP" {
  name                        = "allowDockerTCP"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2376"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.adopResourceGroup.name}"
  network_security_group_name = "${azurerm_network_security_group.adopSecurityGroup.name}"
}

resource "azurerm_network_security_rule" "allowDockerUDP" {
  name                        = "allowDockerUDP"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "25826"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.adopResourceGroup.name}"
  network_security_group_name = "${azurerm_network_security_group.adopSecurityGroup.name}"
}

resource "azurerm_public_ip" "adopEIP" {
  name                         = "adopEIP"
  location                     = "West Europe"
  resource_group_name          = "${azurerm_resource_group.adopResourceGroup.name}"
  public_ip_address_allocation = "static"
}