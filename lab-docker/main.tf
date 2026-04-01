module "vendas" {
  source         = "../modules/nginx" # Onde está a receita do modulo do Nginx
  container_name = "site-de-vendas"    # puxa o valor da variavel do modulo nginx
  external_port  = 8081               # puxa o valor da variavel do modulo nginx
}
module "marketing" {
  source         = "../modules/nginx"
  container_name = "site-de-marketing"
  external_port  = 8082           
}