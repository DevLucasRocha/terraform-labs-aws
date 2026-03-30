# Passo 1: Baixar a imagem do Nginx lá do Docker Hub
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Passo 2: Rodar o contêiner usando a imagem baixada
resource "docker_container" "nginx_server" {
  image = docker_image.nginx.image_id
  name  = "meu-nginx-terraform"
  
  ports {
    internal = 80    # A porta padrão do Nginx lá dentro
    external = 8080  # A porta que vamos acessar no seu navegador
  }
}