resource "local_file" "kubeconfig" {
  depends_on = [
    azurerm_kubernetes_cluster.myaks,
  ]
  filename = var.kube_config
  content  = azurerm_kubernetes_cluster.myaks.kube_config_raw
}