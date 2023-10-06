# Zadanie pierwsze
## Opis
- Instalacja teraform'a na maszynie wirtualnej z systemem operacyjnym Ubuntu.
- Konfiguracja repozytorium terraform
- Dodanie providera docker
- Pobranie obrazu nginx za pomoca IaC w terraform

## Rozwiązanie zadania:
W katalogu Solution_1 znajdziesz rozwiązanie do tego zadania. Zachecam jednak do wykonania samodzielnie ćwiczenia.

## Kroki jakie trzeba wykonać:
1. Instalacja terraform - jak zainstaloać terraform znajdziesz pod tym linkiem: [instalacja terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. Zainstaluj terraform z linku dostepnego powyżej. Jeżeli na kursie korzystasz z udostepnionej maszyny wirtualnej ma juz ona zinstalowanego terraforma.
3. Zainstaluj Docker Engine. Jak zainstalowac docker engine znajdziesz pod tym linkiem: [instalacja docker engine](https://docs.docker.com/engine/install/ubuntu/) - oczywiscie wybierz wersje dla swojego systemu opercyjnego.
4. Podłacz provider docker w swojej konfiguracji terraform, stwórz plik o nazie provider.tf (lub version.tf) i dodaj do niego nastepujacy kod:
```terraform
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}
```
5. Stwórz plik o nazwie main.tf i dodaj do niego nastepujacy kod:
```terraform
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}
```
6. Wydaj komende terraform init - powinien zainstalowac sie provider docker.
7. Wydaj komendę terraform plan - powinien wyswietlic sie plan stworzenia obrazu nginx.
8. Wydaj komende terraform apply - powinien stworzyc sie obraz nginx.
9. Wydaj komende docker images - powinien wyswietlic sie obraz nginx.
10. Wydaj komende terraform destroy - powinien usunac sie obraz nginx.