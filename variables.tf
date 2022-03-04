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

variable "helm_values_linkerd_multicluster" {
  description = "additional values for linked-multicluster release, it's mandatory - there are values that needs to be set, refer to https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = ""
}

variable "multicluster_gateway_enabled" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "true"
}
variable "multicluster_gateway_name" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "linkerd-gateway"
}
variable "multicluster_gateway_port" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "4143"
}
variable "multicluster_gateway_serviceType" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "LoadBalancer"
}
variable "multicluster_gateway_nodePort" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = ""
}
variable "multicluster_gateway_probe_path" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "/ready"
}
variable "multicluster_gateway_probe_port" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "4191"
}
variable "multicluster_gateway_probe_seconds" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "3"
}
variable "multicluster_gateway_serviceAnnotations" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = ""
}
variable "multicluster_gateway_loadBalancerIP" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = ""
}
variable "multicluster_installNamespace" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "true"
}
variable "multicluster_linkerdVersion" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "stable-2.11.1"
}
variable "multicluster_namespace" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "linkerd-multicluster"
}
variable "multicluster_proxyOutboundPort" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "4140"
}
variable "multicluster_remoteMirrorServiceAccount" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "true"
}
variable "multicluster_remoteMirrorServiceAccountName" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "linkerd-service-mirror-remote-access-default"
}
variable "multicluster_linkerdNamespace" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "linkerd"
}
variable "multicluster_identityTrustDomain" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "cluster.local"
}
variable "multicluster_enablePSP" {
  description = "see https://artifacthub.io/packages/helm/linkerd2/linkerd-multicluster?modal=values"
  type        = string
  default     = "false"
}
