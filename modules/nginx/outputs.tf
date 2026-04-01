# modules/nginx/outputs.tf
output "container_url" {
  value = "http://localhost:${var.external_port}"
}