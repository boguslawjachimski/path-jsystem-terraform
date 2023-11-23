# 001 Write Code
Zadanie: Napisz kod terraform który stworzy w digitalocean nastepujące zasoby korzystając z providera [digitalocean](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs):
- projekt o nazwie "stf-`<twojeimie_trzy_pierwsze_znaki>`-`<twojenazwisko_trzy_pierwsze_znaki>`" example: stf-pio-kos
- utworzy siec w regionie fra1 o nazwie stf-`<twojeimie_trzy_pierwsze_znaki>`-`<twojenazwisko_trzy_pierwsze_znaki>`-region-net example: stf-pio-kos-region-net
    - jako adres sieci wykorzystaj 10.10.1XX.0/24 gdzie X to kolejny wolny adres sieci
![PNG GRAPH](/001_terraform_workflow/001_write_code/digitalocean_example/graph.png "Przykład graficzny konfiguracji")