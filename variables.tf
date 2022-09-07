variable "rg" {
  default = {
    "name" = "oreRG2", "location" = "japan east"
  }
}
variable "ingress_name" {
  default = "ore-ingress"
}
variable "deployment_name" {
  default = "mydeploy"
}
variable "deployment_name1" {
  default = "mydeploy1"
}
variable "node_count" {
  default = 1
}
variable "aks-name" {
  default = "aks-dev1"
}
variable "dns_prefix" {
  default = "myfirstaks"
}
variable "kube_config" {
  default = "kubeconfig"
}
variable "typeofsvc" {
  default = "ClusterIP"
}
variable "svcname" {
  default = "mysvc"
}
variable "svcname1" {
  default = "mysvc1"
}
variable "container1" {
  type = map(any)
  default = {
    "image"  = "nigelpoulton/getting-started-k8s:1.0",
    "name"   = "myapp"
    "port"   = 8080
    "cpu"    = 0.5
    "memory" = "512Mi"
  }
}

variable "container2" {
  type = map(any)
  default = {
    "image"  = "nigelpoulton/getting-started-k8s:2.0",
    "name"   = "myapp"
    "port"   = 8080
    "cpu"    = 0.5
    "memory" = "512Mi"
  }
}
variable "label" {
  default = "oreweb"
}
variable "label1" {
  default = "oreweb1"
}