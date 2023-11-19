/*
Blok ten jest często nazywany blokiem zmiennych wejściowych. 
Blok zmiennych zapewnia parametry modułów terraform i umożliwia 
użytkownikom dostosowywanie danych dostarczanych do innych modułów 
terraform bez modyfikowania źródła.

Zmienne często znajdują się w osobnym pliku o nazwie variables.tf. 
Aby użyć zmiennej, należy ją zadeklarować jako blok. Jeden blok dla 
każdej zmiennej.
*/


variable "example_variable" {
  type = string # var_type
  description = "description value of example_variable"
  default = "default value of example_variable"
  sensitive = false
}

/*
Terraform ma ścisłą kolejność ustawiania zmiennych. 
Oto ona, od najwyższej do najniższej:

Linia poleceń ( -vari var-file)
*.auto.tfvars Lub *.auto.tfvars.json
terraform.tfvars.json
terraform.tfvars 
Zmienne Env
Zmienne wartości domyślne
*/