/*

  Due to https://kubernetes.io/docs/reference/using-api/deprecation-guide/#ingress-v122
  Terraform throws the error:
  Error: Failed to create Ingress 'helloworld/helloworld' because: the server could not find the requested resource (post ingresses.extensions)

  
  resource "kubernetes_ingress" "ing" {
  metadata {
    name = var.appname
    namespace = var.appname
  }

  spec {
    ingress_class_name = "nginx"
    backend {
      service_name = var.appname
      service_port = 3000
    }

    rule {
      host = var.hostname
      http {
        path {
          backend {
            service_name = var.appname
            service_port = 3000
          }

          path = "/hello-world"
        }
      }
    }
  }
  wait_for_load_balancer = true
} */


/* Due to https://kubernetes.io/docs/reference/using-api/deprecation-guide/#ingress-v122
  Terraform throws the error:
  Error: Failed to create Ingress 'helloworld/helloworld' because: the server could not find the requested resource (post ingresses.extensions) */


resource "null_resource" "ingress" {
    triggers = {
        always_run = "${timestamp()}"
    }
  provisioner "local-exec" {
    command = "kubectl apply -f ingress.yaml"
    interpreter = ["sh", "-c"]
  }
}


## Workaround to avoid installing external-dns in Kubernetes
resource "null_resource" "get_ingress_hostname" {
    triggers = {
        always_run = "${timestamp()}"
    }
  provisioner "local-exec" {
    command = "kubectl get service/ingress-nginx-controller -n ingress-nginx -o json | jq -r '.status.loadBalancer.ingress[].hostname' >> ${path.module}/ingress_controller_hostname.txt"
    interpreter = ["sh", "-c"]
  }
}

data "local_file" "ingress_hostname" {
  filename = "${path.module}/ingress_controller_hostname.txt"
  depends_on = [null_resource.get_ingress_hostname]
}