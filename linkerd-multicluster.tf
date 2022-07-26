resource "helm_release" "linkerd-multicluster" {
  count = var.enable_linkerd_multicluster == true ? 1 : 0

  name       = "linkerd-multicluster"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-multicluster"
  values = [
    templatefile("${path.module}/multicluster-values.yaml.tpl", {
      installNamespace               = var.multicluster_installNamespace
      linkerdVersion                 = var.linkerd_version
      namespace                      = var.multicluster_namespace
      proxyOutboundPort              = var.multicluster_proxyOutboundPort
      remoteMirrorServiceAccount     = var.multicluster_remoteMirrorServiceAccount
      remoteMirrorServiceAccountName = var.multicluster_remoteMirrorServiceAccountName
      linkerdNamespace               = var.multicluster_linkerdNamespace
      identityTrustDomain            = var.multicluster_identityTrustDomain
      enablePSP                      = var.multicluster_enablePSP

      gateway = {
        enabled     = var.multicluster_gateway_enabled
        name        = var.multicluster_gateway_name
        port        = var.multicluster_gateway_port
        serviceType = var.multicluster_gateway_serviceType
        nodePort    = var.multicluster_gateway_nodePort
        probe = {
          path    = var.multicluster_gateway_probe_path
          port    = var.multicluster_gateway_probe_port
          seconds = var.multicluster_gateway_probe_seconds
        }
        serviceAnnotations = var.multicluster_gateway_serviceAnnotations
        loadBalancerIP     = var.multicluster_gateway_loadBalancerIP
      }
    }),
    var.helm_values_linkerd_multicluster
  ]
  depends_on = [
    helm_release.linkerd
  ]
}
