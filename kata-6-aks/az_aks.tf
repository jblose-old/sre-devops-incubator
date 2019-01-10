variable "az_env" {}
variable "az_suffix" {}
variable "az_service" {}

resource "azurerm_resource_group" "aks" {
    name = "rg-${var.az_env}-${var.az_service}-${var.az_suffix}"
    location = "eastus"
  
    tags {
        environment = "${var.az_env}"
        service = "${var.az_service}"     
    }
}

resource "azurerm_kubernetes_cluster" "aks" {
    name = "${var.az_env}-${var.az_service}-${var.az_suffix}"

}
# resource "azurerm_virtual_network" "pihole" {
#     name = "${var.az_env}-${var.az_service}-vn-${var.az_suffix}"
#     address_space = ["172.31.0.0/16"]
#     location = "${azurerm_resource_group.pihole.location}"
#     resource_group_name = "${azurerm_resource_group.pihole.name}"
# }

# resource "azurerm_subnet" "pihole" {
#     name = "${var.az_env}-${var.az_service}-vn-sub-${var.az_suffix}"
#     resource_group_name = "${azurerm_resource_group.pihole.name}"
#     virtual_network_name = "${azurerm_virtual_network.pihole.name}"
#     address_prefix = "172.31.1.0/24"
# }

# resource "azurerm_public_ip" "pihole" {
#     name = "${var.az_env}-${var.az_service}-ip"
#     location = "${azurerm_resource_group.pihole.location}"
#     resource_group_name = "${azurerm_resource_group.pihole.name}"
#     public_ip_address_allocation = "static"
#     idle_timeout_in_minutes = 30
#     domain_name_label = "${var.az_service}-${var.az_suffix}"

#     tags {
#         environment = "${var.az_env}"  
#         service = "${var.az_service}"      
#     }
# }
# # 
# resource "azurerm_network_interface" "pihole" {
#   name = "centos${var.az_centos_index}-${var.az_env}-${var.az_service}-vn-nic-${var.az_suffix}"
#   location = "${azurerm_resource_group.pihole.location}"
#   resource_group_name = "${azurerm_resource_group.pihole.name}"

#   ip_configuration {
#     name = "centos${var.az_centos_index}-${var.az_env}-${var.az_service}-vn-nic-ipconf-${var.az_suffix}"
#     subnet_id = "${azurerm_subnet.pihole.id}"
#     private_ip_address_allocation = "dynamic"
#     public_ip_address_id = "${azurerm_public_ip.pihole.id}"
#   }

#   tags {
#     environment = "${var.az_env}"
#     service = "${var.az_service}"
#   }
# }

# resource "azurerm_virtual_machine" "pihole" {
#     name = "centos${var.az_centos_index}"
#     location = "${azurerm_resource_group.pihole.location}"
#     resource_group_name = "${azurerm_resource_group.pihole.name}"
#     network_interface_ids = ["${azurerm_network_interface.centos.id}"]
#     vm_size = "Standard_B2s"

#     delete_os_disk_on_termination = true
#     delete_data_disks_on_termination = true

#     storage_image_reference {
#         publisher = "OpenLogic"
#         offer = "CentOS"
#         sku = "7.3"
#         version = "latest"            
#     }

#     storage_os_disk {
#         name = "centos${var.az_centos_index}-disk-${var.az_suffix}"
#         caching = "ReadWrite"
#         create_option = "FromImage"
#         managed_disk_type = "Standard_LRS"
#     }

#     os_profile {
#         computer_name = "centos${var.az_centos_index}"
#         admin_username = "${var.az_centos_admin_user}"
#         admin_password = "${var.az_centos_admin_pass}"
#     }

#     os_profile_linux_config {
#         disable_password_authentication = false
#     }

#     tags {
#         environment = "${var.az_env}"
#     }
# }
