resource "helm_release" "linkerd-failover" {
  count      = var.enable_linkerd_failover == true ? 1 : 0
  name       = "linkerd-failover"
  repository = "https://helm.linkerd.io/edge"
  chart      = "linkerd-failover"
  namespace  = "linkerd"
  version    = ">0.0.0-0"


  depends_on = [
    helm_release.linkerd-control-plane
  ]
}
