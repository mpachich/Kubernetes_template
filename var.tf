variable "kubernetes_ip" {
  description = "Address of kubernetes cluster"
}

variable "k8s_token" {
  description = "Token of your service account"
}

variable "k8s_config_context_cluster" {
  description = "Cluster context of the kube config (name of the kubeconfig cluster, --cluster flag in kubectl)"
  default     = "mycluster.icp"
}

variable "name" {
  description = "Name of kubernets service/pod"
  default     = "random-name"
}
