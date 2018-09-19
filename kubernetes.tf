provider "kubernetes" {
  host                   = "${var.kubernetes_ip}"
  config_context_cluster = "mycluster.icp"
  token                  = "${var.k8s_token}"
  insecure               = "true"
}

resource "kubernetes_service" "test_service" {
  metadata {
    name = "${var.name}"
  }

  spec {
    selector {
      app = "${kubernetes_pod.jenkins.metadata.0.labels.app}"
    }

    port {
      port        = 8080
      target_port = 8080
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

# provider "jenkins" {
#   server_url = "http://localhost:8080/"
#   username   = "user1"
#   password   = "user1"
# }


# resource "jenkins_job" "first" {
#   name         = "TerrTest"
#   display_name = "First terraform test"
#   description  = "This makes a project using terraform"
#   disabled     = false


#   parameters = {}
#   template   = "file://./job_config.xml"
# }

