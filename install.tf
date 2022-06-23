locals {
  values = var.enable_linkerd_ha == true ? "values-ha.yaml" : "values.yaml"
}

resource "helm_release" "linkerd" {
  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  values = [
    file("${path.module}/${local.values}"),
    var.helm_values_linkerd
  ]

  set {
    name  = "clusterDomain"
    value = var.cluster_dns_name
  }

  set_sensitive {
    name  = "identityTrustAnchorsPEM"
    value = var.external_trustanchor ? var.trustanchor_cert.cert_pem : tls_self_signed_cert.trustanchor_cert[0].cert_pem
  }

  set_sensitive {
    name  = "identity.issuer.crtExpiry"
    value = tls_locally_signed_cert.issuer_cert.validity_end_time
  }

  set_sensitive {
    name  = "identity.issuer.tls.crtPEM"
    value = tls_locally_signed_cert.issuer_cert.cert_pem
  }

  set_sensitive {
    name  = "identity.issuer.tls.keyPEM"
    value = tls_private_key.issuer_key.private_key_pem
  }
}
resource "helm_release" "linkerd-viz" {
  count = var.enable_linkerd_viz == true ? 1 : 0

  name       = "linkerd-viz"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-viz"
  values = [
    var.helm_values_linkerd_viz
  ]
  depends_on = [
    helm_release.linkerd
  ]

  set {
    name  = "clusterDomain"
    value = var.cluster_dns_name
  }

  set {
    name  = "prometheus.enabled"
    value = var.external_prometheus_url == "" ? true : false
  }

  set {
    name  = "prometheusUrl"
    value = var.external_prometheus_url
  }
}

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

output "linkerd" {
  value = "If in HA-mode, please refer to https://linkerd.io/2.11/features/ha/ and set label on kube-system: config.linkerd.io/admission-webhooks=disabled"
}