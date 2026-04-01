output "url_nginx" {
    description = "URL para acessar o Nginx rodando no Docker"
    value = "http://localhost:${var.porta_nginx}" 
}