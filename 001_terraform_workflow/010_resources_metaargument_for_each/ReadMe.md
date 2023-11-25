# Metaargument for_each
Dzieki temu argumentowi mozesz operowac na tachich typach jak listy, krotki, mapy i obiekty.

## Zadanie
W tym zadaniu stworzmy katalog `_files` w ktorym bedziemy przechowywać nasze pliki konfiguracyjne.
Wykorzystamy te pliki do konfiguracji naszego środowiska.

- Tworzymy kalatlog `_files`
- W tym katalogu tworzymy plik `vms.json`

```json
{
    "vm1": {
      "id": "vm1",
      "name": "stf-pio-kos-development-fra1-droplet1",
      "region": "fra1",
      "image": "ubuntu-20-04-x64",
      "size": "s-1vcpu-1gb"
    },
    "vm2": {
      "id": "vm2",
      "name": "stf-pio-kos-development-fra1-droplet2",
      "region": "fra1",
      "image": "ubuntu-20-04-x64",
      "size": "s-1vcpu-1gb"
    }
}
```

- Na podstawie pliku `json` stworzymy przy uzyciu meta argument for_each konfiguracje naszych maszych wirtualnych bazując na pliku `vms.json`.
- Skorzystamy tez z wbudowanej funkcji `jsondecode` która pozwoli nam odczytać plik `json` i wykorzystac go w naszej konfiguracji.

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/010_resources_metaargument_for_each/digitalocean_example/graph.png "Przykład graficzny konfiguracji")