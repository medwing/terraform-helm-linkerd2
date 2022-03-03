locals {
  values = var.enable_linkerd_ha == true ? "values-ha.yaml" : "values.yaml"
}

resource "helm_release" "linkerd_ha" {
  count      = var.enable_linkerd_ha == true ? 1 : 0
  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  values = [
    file("${path.module}/${local.values}"),
    var.helm_values
  ]
  set_sensitive {
    name  = "global.identityTrustAnchorsPEM"
    value = tls_self_signed_cert.trustanchor_cert.cert_pem
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

  provisioner "local-exec" {
    command     = "kubectl label namespace kube-system config.linkerd.io/admission-webhooks=disabled --kubeconfig <(echo $KUBECONFIG | base64 --decode)"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = base64encode(var.kubeconfig)
    }
  }
}