resource "helm_release" "linkerd-crds" {
  name             = "linkerd-crds"
  repository       = "https://helm.linkerd.io/stable"
  chart            = "linkerd-crds"
  create_namespace = true
  namespace        = "linkerd"
}
