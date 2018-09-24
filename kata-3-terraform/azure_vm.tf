variable "az_env" {}
variable "az_suffix" {}
variable "az_vm_index" {}

resource "azurerm_resource_group" "vm" {
    name = "${var.az_env}-${var.az_suffix}"
    location = "eastus"
    
    tags {
        environment = "${var.az_env}"
    }
}

resource "azurerm_virtual_network" "vm" {
    name = "${var.az_env}-vn-${var.az_suffix}"
    address_space = ["172.31.0.0/16"]
    location = "${azurerm_resource_group.vm.location}"
    resource_group_name = "${azurerm_resource_group.vm.name}"
}

resource "azurerm_subnet" "vm" {
    name = "${var.az_env}-vn-sub${var.az_vm_index}-${var.az_suffix}"
    resource_group_name = "${azurerm_resource_group.vm.name}"
    virtual_network_name = "${azurerm_virtual_network.vm.name}"
    address_prefix = "172.31.2.0/24"
}

resource "azurerm_public_ip" "vm" {
    name = "${var.az_env}-vm${var.az_vm_index}-ip"
    location = "${azurerm_resource_group.vm.location}"
    resource_group_name = "${azurerm_resource_group.vm.name}"
    public_ip_address_allocation = "static"
    idle_timeout_in_minutes = 30
    
    tags {
        environment = "${var.az_env}"        
    }

}

resource "azurerm_network_interface" "vm" {
  name = "${var.az_env}-vn-sub${var.az_vm_index}-nic-${var.az_suffix}"
  location = "${azurerm_resource_group.vm.location}"
  resource_group_name = "${azurerm_resource_group.vm.name}"

  ip_configuration {
    name = "${var.az_env}-vn-sub${var.az_vm_index}-nic-ipconf-${var.az_suffix}"
    subnet_id = "${azurerm_subnet.vm.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.vm.id}"
  }

  tags {
    environment = "${var.az_env}"
  }
}

# resource "azurerm_virtual_machine" "vm" {
#     name = "centos0${var.az_vm_index}-${var.az_suffix}"
#     location = "${azurerm_resource_group.vm.location}"
#     resource_group_name = "${azurerm_resource_group.vm.name}"
# }
