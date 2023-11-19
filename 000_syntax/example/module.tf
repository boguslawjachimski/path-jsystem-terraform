module "ExampleModule" {
  source = "github.com/terraform-aws-modules/terraform-aws-example-module"

  # insert the 5 required variables here
}

/* Moduły to kontenery na wiele zasobów, które są używane razem. 
Moduł składa się z .tfi/lub .tf.json plików przechowywanych w katalogu. 
Jest to podstawowy sposób pakowania i ponownego wykorzystania zasobów w 
Terraform.

Każda konfiguracja Terraforma posiada przynajmniej jeden model (moduł główny), 
który zawiera zasoby zdefiniowane w .tf plikach. 

Moduły to świetny sposób na dzielenie zbiorów zasobów wielokrotnego użytku w 
wielu konfiguracjach.
*/