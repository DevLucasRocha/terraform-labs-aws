provider "aws" { # serve para configurar o provedor AWS, ou seja, as credenciais e a região onde os recursos serão criados
  access_key = "test"
  secret_key = "test"
  region = "us-east-1"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints { # serve para configurar os endpoints dos serviços da AWS, ou seja, onde os recursos serão criados
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}

resource "aws_instance" "my-first-server" { # serve para criar uma instância EC2, ou seja, um servidor virtual na nuvem da AWS
  ami           = "ami-0c55b159cbfafe1f0" # chave para identificar a imagem da máquina virtual que será usada para criar a instância EC2
  instance_type = "t2.micro" # tipo da instância EC2 que será criada
  tags = {
    name = "ubuntu-server" # tag para identificar a instância EC2 criada
  }
}

resource "aws_vpc" "first-vpc" { # serve para criar uma VPC, ou seja, uma rede virtual na nuvem da AWS
  cidr_block = "10.0.0.0/16" # IP para criar VPC
tags = {
    name = "production"
  }
}

resource "aws_vpc" "second-vpc" { # serve para criar uma VPC, ou seja, uma rede virtual na nuvem da AWS
  cidr_block = "10.1.0.0/16"
tags = {
    name = "Dev"
  }
}

resource "aws_subnet" "subnet-2" { # sub-rede é uma parte da VPC onde os recursos serão criados 
  vpc_id = aws_vpc.second-vpc.id # voce define o vpc e aponta para o id da vpc que voce quer criar a sub-rede por isso se usa .id
  cidr_block = "10.1.1.0/24" # IP da subnet para criar a sub-rede que comunicará com a VPC
  tags = {
    name = "dev-subnet"
  }
}