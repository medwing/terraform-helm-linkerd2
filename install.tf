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
  set_sensitive {
    name  = "identityTrustAnchorsPEM"
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

  # see https://linkerd.io/2.11/features/ha/#exclude-the-kube-system-namespace for details
  provisioner "local-exec" {
    command     = "kubectl label namespace kube-system config.linkerd.io/admission-webhooks=disabled --kubeconfig <(echo $KUBECONFIG | base64 --decode)"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = base64encode(var.kubeconfig)
    }
  }
}