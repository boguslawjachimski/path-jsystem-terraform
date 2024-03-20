resource "aws_instance" "example_resource" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  credit_specification {
    cpu_credits = "unlimited"
  }
}

/*
Bloki zasobów służą do zarządzania zasobami, takimi jak wystąpienia 
obliczeniowe, sieci wirtualne, bazy danych, zasobniki lub zasoby DNS. 
Ten typ bloku jest podstawą każdej konfiguracji terraformu, ponieważ 
reprezentuje rzeczywiste zasoby, a większość innych typów bloków odgrywa 
rolę pomocniczą.
*/
