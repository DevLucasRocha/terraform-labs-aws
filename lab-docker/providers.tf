terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  # No Windows com Docker Desktop, geralmente deixar vazio já funciona, 
  # pois ele acha o motor do Docker sozinho.
}