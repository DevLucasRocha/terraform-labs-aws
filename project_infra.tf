provider "aws" {
  # Simulação do provedor AWS com LocalStack
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}

# ---------------------------------------------------------------------
# VARIÁVEIS: A planilha de dados da nossa infraestrutura
# ---------------------------------------------------------------------
variable "subnet_prefix" {
  description = "Lista de objetos contendo os IPs e os nomes das sub-redes"
  
  # O bloco "default" evita que o Terraform fique te fazendo perguntas no terminal.
  # Ele já lê essa lista e usa esses valores automaticamente.
  default = [
    { cidr_block = "10.0.1.0/24", name = "prod_subnet" },
    { cidr_block = "10.0.2.0/24", name = "dev_subnet" },
    { cidr_block = "10.0.3.0/24", name = "test_subnet" }
  ]
}

# ---------------------------------------------------------------------
# RECURSOS: Onde a construção realmente acontece
# ---------------------------------------------------------------------
resource "aws_vpc" "prod-vpc" {
  # Criando a VPC principal (O terreno de Produção)
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "dynamic_subnets" {
  # -------------------------------------------------------------------
  # O LOOP FOR DO TERRAFORM (count)
  # O comando length() conta quantos itens existem na variável.
  # Como a nossa lista tem 3 itens, o Terraform vai criar 3 sub-redes.
  # -------------------------------------------------------------------
  count             = length(var.subnet_prefix) 
  
  vpc_id            = aws_vpc.prod-vpc.id
  availability_zone = "us-east-1a"

  # O count.index funciona como um ponteiro (0, 1 e 2).
  # Em cada volta do loop, ele puxa o IP e o Nome correspondente da lista.
  cidr_block = var.subnet_prefix[count.index].cidr_block

  tags = {
    Name = var.subnet_prefix[count.index].name
  }
}