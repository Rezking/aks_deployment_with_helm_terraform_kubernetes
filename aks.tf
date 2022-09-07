terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myrg2" {
  name     = var.rg["name"]
  location = var.rg["location"]
}

resource "azurerm_kubernetes_cluster" "myaks" {
  name                = var.aks-name
  location            = azurerm_resource_group.myrg2.location
  resource_group_name = azurerm_resource_group.myrg2.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.myaks.kube_config_raw
  description = "kubeconfig for kubectl access."
  sensitive   = true
}
