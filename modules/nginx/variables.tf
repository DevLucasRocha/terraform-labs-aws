variable "container_name" {
    type = string
    description = "Nome do contêiner docker"
}

variable "external_port" {
    type = number
    description = "Porta externa para acessar o Nginx"
    default = 8080
}