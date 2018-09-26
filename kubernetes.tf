provider "kubernetes" {
  host                   = "${var.kubernetes_ip}"
  config_context_cluster = "mycluster.icp"
  token                  = "${var.k8s_token}"
  insecure               = "true"
}

output "port" {
  value = "${kubernetes_service.jenkins.spec.0.port.0.node_port}"
}

resource "kubernetes_service" "jenkins" {
  metadata {
    name = "jenkins"
  }

  spec {
    selector {
      app = "${kubernetes_pod.jenkins.metadata.0.labels.app}"
    }

    port {
      port        = 8080
      target_port = 8080

      # node_port   = 30001
    }

    type = "NodePort"
  }
}

resource "kubernetes_pod" "jenkins" {
  metadata {
    name = "${var.name}"

    labels {
      app = "jenkins"
    }
  }

  spec {
    container {
      image = "mpachich/jenkins:2"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}
