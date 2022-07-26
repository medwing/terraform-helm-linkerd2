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
    name  = "linkerdVersion"
    value = var.linkerd_version
  }

  set {
    name  = "clusterDomain"
    value = var.cluster_dns_name
  }

  set_sensitive {
    name  = "identityTrustAnchorsPEM"
    value = var.external_trustanchor
      ? var.trustanchor_cert.cert_pem
      : tls_self_signed_cert.trustanchor_cert[0].cert_pem
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

output "linkerd" {
  value = "If in HA-mode, please refer to https://linkerd.io/2.11/features/ha/ and set label on kube-system: config.linkerd.io/admission-webhooks=disabled"
}