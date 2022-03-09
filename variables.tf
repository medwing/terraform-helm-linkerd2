variable "enable_linkerd_ha" {
  description = "Enable Linkerd HA Mode for production cluster if true"
  type        = bool
  default     = false
}

variable "helm_values_linkerd" {
  description = "helm chart values.yaml to be used in addtion"
  type        = string
  default     = ""
}

variable "enable_linkerd_viz" {
  description = "install linkerd viz"
  type        = bool
  default     = false
}

variable "helm_values_linkerd_viz" {
  description = "additional values for linked-viz release"
  type        = string
  default     = ""
}

variable "external_prometheus_url" {
  description = "disable internal prometheus in favour of external prometheus by supplying prometheus url. See https://linkerd.io/2.11/tasks/external-prometheus/"
  type        = string
  default     = ""
}

variable "enable_linkerd_multicluster" {
  description = "install linkerd multicluster"
  type        = bool
  default     = false
}
