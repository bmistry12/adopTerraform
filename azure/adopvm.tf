resource "azurerm_network_interface" "adopNetworkInterface" {
  name                = "adopNetworkInterface"
  location            = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name = "${azurerm_resource_group.adopResourceGroup.name}"

  ip_configuration {
    name                          = "adopIPConfig"
    subnet_id                     = "${azurerm_subnet.adopSubnet.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "172.31.64.10" //in the cidr range but not subnet
    public_ip_address_id          = "${azurerm_public_ip.adopEIP.id}"
  }
}

resource "azurerm_virtual_machine" "adopVirtualMachine" {
  name                  = "adopVirtualMachine"
  location              = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name   = "${azurerm_resource_group.adopResourceGroup.name}"
  network_interface_ids = ["${azurerm_network_interface.adopNetworkInterface.id}"]
  vm_size               = "${var.vm_size}"

  # Deletes the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Deletes the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name            = "adopOSDisk1"
    caching         = "ReadWrite"
    create_option   = "FromImage"
    managed_disk_id = "Standard_LRS"
    disk_size_gb    = 50
  }

  os_profile {
    computer_name  = "ADOP"
    admin_username = "centos"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = "${var.public_key}"
      path     = "/home/centos/.ssh/authorized_keys"
    }
  }

  tags {
    environment      = "staging"
    Name             = "bhavAdopInstance"
    Service          = "ADOP-C"
    NetworkTier      = "private"
    ServiceComponent = "ApplicationServer"
  }
}

/* resource "azurerm_managed_disk" "sda1" {
  name                 = "sda1"
  location             = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name  = "${azurerm_resource_group.adopResourceGroup.location}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8
}

resource "azurerm_virtual_machine_data_disk_attachment" "sda1" {
  managed_disk_id    = "${azurerm_managed_disk.sda1.id}"
  virtual_machine_id = "${azurerm_virtual_machine.adopVirtualMachine.id}"
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "sdf" {
  name                 = "sdf"
  location             = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name  = "${azurerm_resource_group.adopResourceGroup.location}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 15
}

resource "azurerm_virtual_machine_data_disk_attachment" "sdf" {
  managed_disk_id    = "${azurerm_managed_disk.sdf.id}"
  virtual_machine_id = "${azurerm_virtual_machine.adopVirtualMachine.id}"
  lun                = "11"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "sdg" {
  name                 = "sdg"
  location             = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name  = "${azurerm_resource_group.adopResourceGroup.location}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 25
}

resource "azurerm_virtual_machine_data_disk_attachment" "sdg" {
  managed_disk_id    = "${azurerm_managed_disk.sdg.id}"
  virtual_machine_id = "${azurerm_virtual_machine.adopVirtualMachine.id}"
  lun                = "12"
  caching            = "ReadWrite"
}

resource "azurerm_managed_disk" "sdh" {
  name                 = "sdh"
  location             = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name  = "${azurerm_resource_group.adopResourceGroup.location}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 25
}

resource "azurerm_virtual_machine_data_disk_attachment" "sdh" {
  managed_disk_id    = "${azurerm_managed_disk.sdh.id}"
  virtual_machine_id = "${azurerm_virtual_machine.adopVirtualMachine.id}"
  lun                = "13"
  caching            = "ReadWrite"
}
 */
resource "azurerm_virtual_machine_extension" "adopUserData" {
  name                 = "adopUserData"
  location             = "${azurerm_resource_group.adopResourceGroup.location}"
  resource_group_name  = "${azurerm_resource_group.adopResourceGroup.name}"
  virtual_machine_name = "${azurerm_virtual_machine.adopVirtualMachine.name}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
      "commandToExecute": "sleep 30 && curl -L https://gist.githubusercontent.com/bmistry12/6a4296de580f69158f864546ee6ecb6d/raw/ADOPC-User-Data.sh > ~/userData.sh && chmod +x ~/userData.sh && export INITIAL_ADMIN_USER=${var.adop_username} && export INITIAL_ADMIN_PASSWORD_PLAIN=${var.adop_password} && cd ~/ && ./userData.sh"
    }
SETTINGS
}
