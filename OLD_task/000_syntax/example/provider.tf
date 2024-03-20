provider "aws" {
  region = "us-east-1"
  version = "~> 3.0"
}

/*
Bloki dostawców określają specjalny typ modułu, który umożliwia 
Terraformowi interakcję z różnymi platformami hostingu w chmurze 
lub centrami danych. Dostawcy muszą zostać skonfigurowani z odpowiednimi 
poświadczeniami, zanim będziemy mogli z nich korzystać. 

Wersje i lokalizacje pobierania dostawców są często określone w terraform 
bloku, w provider są uznawane za depricated.
*/
