resource "helm_release" "metrics_server" {
  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = var.metrics_chart_name
  namespace  = var.metrics_namespace
  version    = var.metrics_release_version

  values = [file("${path.module}/values/metrics-server.yaml")]

}
