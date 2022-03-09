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

variable "enable_linkerd_multicluster" {
  description = "install linkerd multicluster"
  type        = bool
  default     = false
}
