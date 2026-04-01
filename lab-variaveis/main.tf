data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.tipo_instancia
  user_data    = <<-EOF
                #!/bin/bash
                apt update -y
                apt install nginx -y
                systemctl start nginx
                systemctl enable nginx
                EOF
  vpc_security_group_ids = [aws_security_group.web_sg.id] # associar o SG criado

  tags = {
    Name = var.instancia_nome
  }
}

resource "aws_security_group" "web_sg" { # obrigatório criar um SG para permitir o acesso HTTP
  name        = "permitir_http"
  description = "Permitir trafego web na porta 80"

  ingress {
    description = "HTTP da internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Isso significa "qualquer IP do mundo"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Isso significa "todos os protocolos"
    cidr_blocks = ["0.0.0.0/0"] # Permitir saída para qualquer lugar
  }
}

output "ip_da_maquina" {
  description = "Endereço IP público simulado da nossa instância"
  value       = aws_instance.app_server.public_ip
}