variable "enable_linkerd_ha" {
  description = "Enable Linkerd HA Mode for production cluster if true"
  type        = bool
  default     = false
}

variable "kubeconfig" {
  description = "kubeconfig for cluster administration, needed in ha mode to stop from deploying proxy into kube-system"
  type = string
  default = ""
}