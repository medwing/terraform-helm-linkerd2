resource "helm_release" "linkerd-smi" {
  count      = var.enable_linkerd_smi == true ? 1 : 0
  name       = "linkerd-smi"
  repository = "https://linkerd.github.io/linkerd-smi"
  chart      = "linkerd-smi"
  namespace  = "linkerd"
  set {
    name  = "clusterDomain"
    value = var.cluster_dns_name
  }
  depends_on = [
    helm_release.linkerd-control-plane
  ]
}
