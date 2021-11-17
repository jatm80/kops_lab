resource "kubernetes_service" "srv" {
  metadata {
    name = var.appname
    namespace = var.appname
  }
  spec {
    selector = {
      app = kubernetes_deployment.dep.metadata.0.labels.app
    }
    cluster_ip = "None"
    port {
      port        = 3000
      protocol    = "TCP"
    }
  }
}