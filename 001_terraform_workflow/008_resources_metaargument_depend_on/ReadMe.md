# Metaargument depend_on

Użyj depends_on metaargumentu, aby obsłużyć ukryte zależności zasobów lub modułów, których Terraform nie może automatycznie wywnioskować. Musisz tylko jawnie określić zależność, gdy zasób lub moduł opiera się na zachowaniu innego zasobu, ale nie uzyskuje dostępu do żadnych danych tego zasobu w swoich argumentach.

## Zadanie 1: Metaargument depend_on
Dodaj prosze parametr `depends_on` do zasobu `digitalocean_droplet` i jako wartość podaj `digitalocean_vpc` który utworzyliśmy w poprzednim zadaniu.

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/008_resources_metaargument_depend_on/digitalocean_example/graph.png "Przykład graficzny konfiguracji")