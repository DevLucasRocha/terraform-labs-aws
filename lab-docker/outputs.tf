# lab-docker/outputs.tf
output "url_vendas" {
  value = module.vendas.container_url
}

output "url_marketing" {
  value = module.marketing.container_url
}