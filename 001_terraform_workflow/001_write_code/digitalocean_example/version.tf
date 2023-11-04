# Powinniśmy zacząc od tego pliku który będzie zawierał wersje naszych providerów
# W tym przypadku mamy tylko jeden provider, ale w przypadku gdybyśmy mieli ich więcej
# to w tym pliku powinniśmy zdefiniować wersje dla każdego z nich
# W tym przypadku wersja jest zdefiniowana jako "~> 2.0" co oznacza że Terraform
# będzie używał wersji 2.x.x, ale nie będzie aktualizował do wersji 3.x.x
# Jeśli chcemy zaktualizować wersje do 3.x.x to musimy to zrobić ręcznie
# Możemy też okreslić wersje naszego terraform.
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.14.0"
}