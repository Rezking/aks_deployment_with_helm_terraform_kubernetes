provider "kubernetes" {
  config_path    = local_file.kubeconfig.filename
  config_context = var.aks-name
}

resource "kubernetes_deployment" "mydeploy" {
  metadata {
    name = var.deployment_name
    labels = {
      app = var.label
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.label
      }
    }
    template {
      metadata {
        labels = {
          app = var.label
        }
      }

      spec {
        container {
          image         = var.container1["image"]
          name          = var.container1["name"]
          port{
            container_port = var.container1["port"]
          }
          resources {
            limits = {
              cpu    = var.container1["cpu"]
              memory = var.container1["memory"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "mydeploy1" {
  metadata {
    name = var.deployment_name1
    labels = {
      app = var.label1
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.label1
      }
    }
    template {
      metadata {
        labels = {
          app = var.label1
        }
      }

      spec {
        container {
          image         = var.container2["image"]
          name          = var.container2["name"]
          port{
            container_port = var.container2["port"]
          }
          resources {
            limits = {
              cpu    = var.container2["cpu"]
              memory = var.container2["memory"]
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "myservice" {
  metadata {
    name = var.svcname
  }
  spec {
    selector = {
      app = kubernetes_deployment.mydeploy.metadata.0.labels.app
    }
    port{
      port        = var.container1["port"]
      target_port = var.container1["port"]
    }
    type = var.typeofsvc
  }
}

resource "kubernetes_service" "myservice1" {
  metadata {
    name = var.svcname1
  }
  spec {
    selector = {
      app = kubernetes_deployment.mydeploy1.metadata.0.labels.app
    }
    port{
      port        = var.container2["port"]
      target_port = var.container2["port"]
    }
    type = var.typeofsvc
  }
}

resource "kubernetes_ingress_v1" "myingress"{
  wait_for_load_balancer = true
  metadata{
    name = var.ingress_name
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          backend {
            service {
              name = var.svcname
              port {
                number = var.container1["port"]
              }
            }
          }
          path = "/"
          path_type = "Prefix"
        }
        path {
          backend {
            service {
              name = var.svcname1
              port {
                number = var.container2["port"]
              }
            }
          }
          path = "/v1"
          path_type = "Prefix"
        }
      }
    }
  }
}