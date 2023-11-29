# 001 Write Code
## Zadanie: 

Praca z cloud digitalocean wymaga:

1. Posiadania konta w digitalocean - załuż konto i w sekcji api wygeneruj token zapisz go sobie do pliku
2. Posiadany token zapisz w pliku .auto.tfvrs w katalogu 001_write_code w podkatalogu digitalocean_example
```hcl
do_token = "wartość_token"
```
3. Bardziej szczegołową konfigurację znajdziesz w [dokumentacji](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs) i przykład jak używaće [digitalocean_example](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs#example-usage)

## Zadanie:

Napisz kod terraform który stworzy w digitalocean nastepujące zasoby: 
1. Project - patrz [digitalocean_project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project)
2. Network (VPC) - patrz [digitalocean_vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc)

Korzystając z providera [digitalocean](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs) stwórz zasoby w nastepującej konfiguracji:
1. Resources = `digitalocean_project`:
    - name = "stf-`<twojeimie_trzy_pierwsze_znaki>`-`<twojenazwisko_trzy_pierwsze_znaki>`" example: stf-pio-kos
2. Resources = `digitalocean_vpc`: 
    - region = fra1 
    - name = "stf-`<twojeimie_trzy_pierwsze_znaki>`-`<twojenazwisko_trzy_pierwsze_znaki>`-region-net" example: stf-pio-kos-region-net
    - iprange = "jako adres sieci wykorzystaj 10.1XY.1XY.0/24 gdzie XY to dwa ostatnie numery twojego ID studenta" example: "10.113.113.0/24"

## Plan infrastruktury:
Poniżej znajdziesz diagram konfiguracji postaraj sie uzyskać taką samą konfigurację:

![PNG GRAPH](/001_terraform_workflow/001_write_code/digitalocean_example/graph.png "Przykład graficzny konfiguracji")