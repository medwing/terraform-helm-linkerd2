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