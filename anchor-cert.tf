// Create trusted Anchor Certificate

resource "tls_private_key" "trustanchor_key" {
  count       = try(var.trustanchor_key, false) ? 0 : 1
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "trustanchor_cert" {
  count                 = try(var.trustanchor_cert, false) ? 0 : 1
  key_algorithm         = tls_private_key.trustanchor_key[0].algorithm
  private_key_pem       = tls_private_key.trustanchor_key[0].private_key_pem
  validity_period_hours = 87600
  is_ca_certificate     = true

  subject {
    common_name = "identity.linkerd.cluster.local"
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
  key_algorithm   = try(var.trustanchor_key, false) ? var.trustanchor_key.algorithm : tls_private_key.trustanchor_key[0].algorithm
  private_key_pem = try(var.trustanchor_key, false) ? var.trustanchor_key.private_key_pem : tls_private_key.trustanchor_key[0].private_key_pem

  subject {
    common_name = "identity.linkerd.cluster.local"
  }
}

resource "tls_locally_signed_cert" "issuer_cert" {
  cert_request_pem      = tls_cert_request.issuer_req.cert_request_pem
  ca_key_algorithm      = try(var.trustanchor_key, false) ? var.trustanchor_key.algorithm : tls_private_key.trustanchor_key[0].algorithm
  ca_private_key_pem    = try(var.trustanchor_key, false) ? var.trustanchor_key.private_key_pem : tls_private_key.trustanchor_key[0].private_key_pem
  ca_cert_pem           = try(var.trustanchor_cert, false) ? var.trustanchor_cert.cert_pem : tls_self_signed_cert.trustanchor_cert[0].cert_pem
  validity_period_hours = 8760
  is_ca_certificate     = true

  allowed_uses = [
    "crl_signing",
    "cert_signing",
    "server_auth",
    "client_auth"
  ]
}
