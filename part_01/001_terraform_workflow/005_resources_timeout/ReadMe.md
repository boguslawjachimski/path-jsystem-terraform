# Resources timeout
W tym ćwiczeniu zobaczymy jak mozemy sterować czasem:
- create
- update
- delete
po upływie którego terraform zgłosi błąd jezeli jedna z akcji nie wykona się na czas.

## Zadanie
Do poprzedniego zasobu dodaj prosze parametr `timeouts` z wartością `create = "Xs"` 
- ustaw na wrstość 5s tak by sprawdzić jak zachowa się terraform jak nie uda mu sie stworzyć zasobu. 
- Potem zwieksz wartość i obserwuj plan oraz apply. Sprawdz inne wartości timeouts.

```hcl
...
# Dodaj to do swojego bloku resources. Oczywiście odpowiednio zmodyfikuj wartości dla create, update i delete.
  timeouts {
    create = "50s"
    update = "100s"
    delete = "30s"
  }
...
```

Mozesz zabserwować ze te atrybuty odpwiadaja odpowiednio akcja z terraform Add, Change, Destroy

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/005_resources_timeout/digitalocean_example/graph.png "Przykład graficzny konfiguracji")