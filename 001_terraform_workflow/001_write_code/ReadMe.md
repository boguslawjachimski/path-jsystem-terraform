# 001 Write Code
## Zadanie: 

Napisz kod terraform który stworzy w digitalocean nastepujące zasoby: 
1. Project
2. Network (VPC)

Korzystając z providera [digitalocean](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs) stwórz zasoby w nastepującej konfiguracji:
1. Resources = `digitalocean_project`:
    - name = "stf-`<twojeimie_trzy_pierwsze_znaki>`-`<twojenazwisko_trzy_pierwsze_znaki>`" example: stf-pio-kos
2. Resources = `digitalocean_vpc`: 
    - region = fra1 
    - name = "stf-`<twojeimie_trzy_pierwsze_znaki>`-`<twojenazwisko_trzy_pierwsze_znaki>`-region-net" example: stf-pio-kos-region-net
    - iprange = "jako adres sieci wykorzystaj 10.1XY.1XY.0/24 gdzie XY to dwa ostatnie numery twojego ID studenta" example: "10.113.113.0/24"

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/001_write_code/digitalocean_example/graph.png "Przykład graficzny konfiguracji")