variable "az_env" {}
variable "az_suffix" {}
variable "az_service" {}
variable "az_client_id" {}
variable "az_client_secret" {}

resource "azurerm_resource_group" "aks" {
    name = "rg-${var.az_env}-${var.az_service}-${var.az_suffix}"
    location = "eastus"
  
    tags {
        environment = "${var.az_env}"
        service = "${var.az_service}"     
    }
}
resource "azurerm_public_ip" "aks" {
    name = "ip-${var.az_env}-${var.az_service}-${var.az_suffix}"
    location = "${azurerm_resource_group.aks.location}"
    resource_group_name = "MC_${azurerm_resource_group.aks.name}_${var.az_env}${var.az_service}${var.az_suffix}_eastus"
    public_ip_address_allocation = "static"
    idle_timeout_in_minutes = 30
    domain_name_label = "aks-${var.az_suffix}"

    tags {
        environment = "${var.az_env}"        
    }
}
resource "azurerm_kubernetes_cluster" "aks" {
    name = "${var.az_env}${var.az_service}${var.az_suffix}"
    location = "${azurerm_resource_group.aks.location}"
    resource_group_name = "${azurerm_resource_group.aks.name}"
    dns_prefix = "${var.az_env}-${var.az_service}-${var.az_suffix}"
    kubernetes_version = "1.11.5"

    agent_pool_profile {
        name = "${var.az_env}${var.az_service}${var.az_suffix}"
        count = 1
        vm_size = "Standard_B2s"
        os_type = "Linux"
        os_disk_size_gb = 30
    }

    service_principal {
        client_id     = "${var.az_client_id}"
        client_secret = "${var.az_client_secret}"
    }

     tags {
        environment = "${var.az_env}"
        service = "${var.az_service}"     
    }
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
}