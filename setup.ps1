# Instala o Terraform
winget install Hashicorp.Terraform --accept-package-agreements --accept-source-agreements

# Instala o AWS CLI (Para interagir com o LocalStack)
winget install Amazon.AWSCLI --accept-package-agreements --accept-source-agreements

Write-Host "Instalação concluída! Feche e abra o terminal novamente." -ForegroundColor Green