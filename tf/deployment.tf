resource "kubernetes_deployment" "dep" {
  depends_on = [
    kubernetes_namespace.ns
  ]
  metadata {
    name = var.appname
    namespace = var.appname
    labels = {
      app = var.appname
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.appname
      }
    }

    template {
      metadata {
        labels = {
          app = var.appname
        }
      }

      spec {
        container {
          image = var.image
          name  = var.appname

          liveness_probe {
            http_get {
              path = "/hello-world"
              port = 3000
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}