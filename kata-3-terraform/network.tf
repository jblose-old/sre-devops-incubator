resource "azurerm_resource_group" "prd" {
    name = "prd-jblose"
    location = "eastus"
    
    tags {
        environment = "prd"
    }
}

resource "azurerm_virtual_network" "prd" {
    name = "prd-vn-jblose"
    address_space = ["172.31.0.0/16"]
    location = "${azurerm_resource_group.prd.location}"
    resource_group_name = "${azurerm_resource_group.prd.name}"
}

resource "azurerm_subnet" "prd" {
  name                 = "prd-vn-sub01-jblose"
  resource_group_name  = "${azurerm_resource_group.prd.name}"
  virtual_network_name = "${azurerm_virtual_network.prd.name}"
  address_prefix       = "172.31.2.0/24"
}

resource "azurerm_public_ip" "prd" {
    name = "prd-vm01-ip"
    location = "${azurerm_resource_group.prd.location}"
    resource_group_name = "${azurerm_resource_group.prd.name}"
    public_ip_address_allocation = "static"
    idle_timeout_in_minutes = 30
    
    tags {
        environment = "prd"        
    }

}

resource "azurerm_network_interface" "prd" {
  name                = "prd-vn-sub01-nic-jblose"
  location            = "${azurerm_resource_group.prd.location}"
  resource_group_name = "${azurerm_resource_group.prd.name}"

  ip_configuration {
    name                          = "prd-vn-sub01-nic-ipconf-jblose"
    subnet_id                     = "${azurerm_subnet.prd.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.prd.id}"
  }

  tags {
    environment = "prd"
  }
}