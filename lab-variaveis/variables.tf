variable "instancia_nome" {
  type        = string
  description = "O nome que aparecerá na Tag Name da instância"
  default     = "servidor-web-estudo"
}

variable "tipo_instancia" {
  type        = string
  description = "O hardware da máquina (ex: t2.micro, t3.small)"
  default     = "t2.micro"
}