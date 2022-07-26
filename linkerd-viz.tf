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
    name  = "linkerdVersion"
    value = var.linkerd_version
  }

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
