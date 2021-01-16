## VPC
variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

## Google K8s
variable "gke_username" {
  description = "gke username"
}

variable "gke_password" {
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}



