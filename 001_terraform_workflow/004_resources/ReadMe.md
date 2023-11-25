# Resources (Zasoby)

Choć juz pracowaliśmy z zasobami w poprzednich zadaniach, to teraz zaczniemy je bardziej szczegółowo omawiać.

## Zadanie:

- w tym zadaniu dodamy naszą maszyne wirtualną do naszego kodu terraform skorzystamy z zasobu `digitalocean_droplet`:
1. `digitalocean_droplet`:
    - name = nazwa maszyny wirtualnej niech zaczyna sie od `sft-<twoje inicjały(trzylitery imienia i nazwiska)>-droplet`
    - image = "ubuntu-20-04-x64"
    - region = "fra1"
    - size = "s-1vcpu-1gb"
    - tags = "stf, `<imie_nazwisko>`" - dwa tagi oddzielone przecinkiem.

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/004_resources/digitalocean_example/graph.png "Przykład graficzny konfiguracji")