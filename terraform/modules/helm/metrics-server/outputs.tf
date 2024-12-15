output "release_description" {
  value = helm_release.metrics_server.description
}

output "release_status" {
  value = helm_release.metrics_server.status
}
