// Create trusted Anchor Certificate

locals {
  cert_domains = [
    var.cluster_dns_name,
    "*.${var.cluster_dns_name}",
    "*.cluster.local"
  ]
}

resource "tls_private_key" "trustanchor_key" {
  count       = var.external_trustanchor ? 0 : 1
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "trustanchor_cert" {
  count                 = var.external_trustanchor ? 0 : 1
  private_key_pem       = tls_private_key.trustanchor_key[0].private_key_pem
  validity_period_hours = 87600
  is_ca_certificate     = true

  uris = local.cert_domains

  dns_names = local.cert_domains

  subject {
    common_name = "root.linkerd.${var.cluster_dns_name}"
  }

  allowed_uses = [
    "crl_signing",
    "cert_signing",
    "server_auth",
    "client_auth"
  ]
}

resource "tls_private_key" "issuer_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_cert_request" "issuer_req" {
  private_key_pem = tls_private_key.issuer_key.private_key_pem

  uris = local.cert_domains

  dns_names = local.cert_domains

  subject {
    common_name = "identity.linkerd.${var.cluster_dns_name}"
  }
}

resource "tls_locally_signed_cert" "issuer_cert" {
  cert_request_pem      = tls_cert_request.issuer_req.cert_request_pem
  ca_private_key_pem    = var.external_trustanchor ? var.trustanchor_key.private_key_pem : tls_private_key.trustanchor_key[0].private_key_pem
  ca_cert_pem           = var.external_trustanchor ? var.trustanchor_cert.cert_pem : tls_self_signed_cert.trustanchor_cert[0].cert_pem
  validity_period_hours = 8760
  is_ca_certificate     = true

  allowed_uses = [
    "crl_signing",
    "cert_signing",
    "server_auth",
    "client_auth"
  ]
}
