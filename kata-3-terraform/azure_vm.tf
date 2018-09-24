variable "az_env" {}
variable "az_suffix" {}
variable "az_centos_index" {}
variable "az_centos_admin_user" {}
variable "az_centos_admin_pass" {}

resource "azurerm_resource_group" "centos" {
    name = "${var.az_env}-${var.az_suffix}"
    location = "eastus"
    
    tags {
        environment = "${var.az_env}"
    }
}

resource "azurerm_virtual_network" "centos" {
    name = "${var.az_env}-vn-${var.az_suffix}"
    address_space = ["172.31.0.0/16"]
    location = "${azurerm_resource_group.centos.location}"
    resource_group_name = "${azurerm_resource_group.centos.name}"
}

resource "azurerm_subnet" "centos" {
    name = "${var.az_env}-vn-sub${var.az_centos_index}-${var.az_suffix}"
    resource_group_name = "${azurerm_resource_group.centos.name}"
    virtual_network_name = "${azurerm_virtual_network.centos.name}"
    address_prefix = "172.31.2.0/24"
}

resource "azurerm_public_ip" "centos" {
    name = "${var.az_env}-centos${var.az_centos_index}-ip"
    location = "${azurerm_resource_group.centos.location}"
    resource_group_name = "${azurerm_resource_group.centos.name}"
    public_ip_address_allocation = "static"
    idle_timeout_in_minutes = 30
    domain_name_label = "centos${var.az_centos_index}-${var.az_suffix}"

    tags {
        environment = "${var.az_env}"        
    }
}

resource "azurerm_network_interface" "centos" {
  name = "centos${var.az_centos_index}-${var.az_env}-vn-nic-${var.az_suffix}"
  location = "${azurerm_resource_group.centos.location}"
  resource_group_name = "${azurerm_resource_group.centos.name}"

  ip_configuration {
    name = "centos${var.az_centos_index}-${var.az_env}-vn-nic-ipconf-${var.az_suffix}"
    subnet_id = "${azurerm_subnet.centos.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.centos.id}"
  }

  tags {
    environment = "${var.az_env}"
  }
}

resource "azurerm_virtual_machine" "centos" {
    name = "centos${var.az_centos_index}"
    location = "${azurerm_resource_group.centos.location}"
    resource_group_name = "${azurerm_resource_group.centos.name}"
    network_interface_ids = ["${azurerm_network_interface.centos.id}"]
    vm_size = "Standard_B2s"

    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    storage_image_reference {
        publisher = "OpenLogic"
        offer = "CentOS"
        sku = "7.3"
        version = "latest"            
    }

    storage_os_disk {
        name = "centos${var.az_centos_index}-disk-${var.az_suffix}"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name = "centos${var.az_centos_index}"
        admin_username = "${var.az_centos_admin_user}"
        admin_password = "${var.az_centos_admin_pass}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags {
        environment = "${var.az_env}"
    }
}
