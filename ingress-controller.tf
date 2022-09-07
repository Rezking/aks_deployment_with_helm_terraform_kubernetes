provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
    # config_context = var.aks-name
  }
}

resource "helm_release" "nginx_ingress" {
  name = "nginx"
  chart      = "fill_with_chart_url"
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}