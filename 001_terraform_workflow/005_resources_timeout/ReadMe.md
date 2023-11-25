# Resources timeout
Do poprzedniego zasobu dodaj prosze parametr `timeouts` z wartością `create = "Xs"`.

- w tym zadaniu dodamy naszą maszyne wirtualną do naszego kodu terraform
    - name = nazwa maszyny wirtualnej niech zaczyna sie od `sft-<twoje inicjały(trzylitery imienia i nazwiska)>-vm`
    - image = "ubuntu-20-04-x64"
    - region = "fra1"
    - size = "s-1vcpu-1gb"
    - tags = "stf, `<imie_nazwisko>`"

- A wiec dodajmy nasz timeouts


## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/005_resources_timeout/digitalocean_example/graph.png "Przykład graficzny konfiguracji")