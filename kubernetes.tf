provider "kubernetes" {
  host                   = "${var.kubernetes_ip}"
  config_context_cluster = "mycluster.icp"
  token                  = "${var.k8s_token}"
  insecure               = "true"
}

output "port" {
  value = "4"
}

resource "kubernetes_service" "test_service" {
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
      image = "mpachich/terrafor-jenkins:1"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}
