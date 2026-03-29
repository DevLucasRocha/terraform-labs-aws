provider "aws" {
  # ---------------------------------------------------------
  # CONFIGURAÇÃO DO PROVEDOR (A conexão com a nuvem)
  # Serve para configurar as credenciais e a região.
  # ---------------------------------------------------------
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  # As linhas abaixo enganam o Terraform para ele não buscar credenciais reais na Amazon
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    # Redireciona o fluxo para o nosso Docker local (LocalStack) em vez da nuvem real
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}

resource "aws_vpc" "first-vpc" {
  # ---------------------------------------------------------
  # VPC: O grande "terreno" murado na nuvem.
  # O cidr_block /16 define que esse terreno cabe 65.536 IPs.
  # ---------------------------------------------------------
  cidr_block = "10.0.0.0/16" 
  tags = {
    Name = "production"
  }
}

resource "aws_vpc" "second-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "Dev"
  }
}

resource "aws_subnet" "subnet-2" {
  # ---------------------------------------------------------
  # SUB-REDE: Uma "rua" ou divisão dentro do terreno da VPC.
  # O cidr_block /24 define que esta rua cabe 256 IPs.
  # ---------------------------------------------------------
  vpc_id     = aws_vpc.second-vpc.id # Puxa o ID gerado automaticamente pela second-vpc
  cidr_block = "10.1.1.0/24"         
  
  tags = {
    Name = "dev-subnet"
  }
}

resource "aws_instance" "my-first-server" {
  # ---------------------------------------------------------
  # EC2: Um servidor virtual (computador) na nuvem da AWS.
  # ---------------------------------------------------------
  ami           = "ami-0c55b159cbfafe1f0" # O "molde" do sistema operacional (ex: Ubuntu)
  instance_type = "t2.micro"              # O tamanho da máquina (CPU e Memória)
  
  tags = {
    Name = "ubuntu-server" 
  }
}