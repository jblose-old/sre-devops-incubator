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
    location = "${azurerm_resource_group.aks.location}"
    resource_group_name = "${azurerm_resource_group.aks.name}"
    dns_prefix = "${var.az_env}-${var.az_service}-${var.az_suffix}"

    agent_pool_profile {
        name = "${var.az_env}-${var.az_service}-${var.az_suffix}-default"
        count = 1
        vm_size = "Standard_B2s"
        os_type = "Linux"
        os_disk_size_gb = 30
    }

# Need to configure Service Principal 
    service_principal {
        client_id     = "00000000-0000-0000-0000-000000000000"
        client_secret = "00000000000000000000000000000000"
    }
}
