terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
      }
    }
}

/*
Blok Terraform służy do ustawienia żądanej wersji terraformu. 
Może również zawierać required_providersblok określający wersje dostawców, 
których potrzebujemy, a także miejsce, z którego Terraform powinien pobrać 
tych dostawców. Blok Terraform jest często umieszczany w osobnym pliku, 
zwanym terraform.tf w celu oddzielenia ustawień od własnego pliku. 

required_providers – blok określający wersję dostawców, w tym przypadku jest 
to AWS. Informacje o danym providers oraz o jego wersji widzimy w wartości 
identyfikatoru source i version w bloku aws. 

Blok aws – w tym przypadku nazwa ta jest nazwą naszego providera z rejestru, 
source określa źródło danego providera.
*/