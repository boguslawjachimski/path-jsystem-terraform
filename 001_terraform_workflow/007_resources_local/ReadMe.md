# Zasoby dostępne wyłącznie lokalnie

Chociaż większość typów zasobów odpowiada typowi obiektu infrastruktury zarządzanego za pośrednictwem zdalnego interfejsu API sieci, istnieją pewne wyspecjalizowane typy zasobów, które działają tylko w samym Terraformie, obliczając niektóre wyniki i zapisując je w stanie do wykorzystania w przyszłości.

Na przykład istnieją typy zasobów dostępne wyłącznie lokalnie, które służą do generowania kluczy prywatnych , wydawania samopodpisanych certyfikatów TLS , a nawet generowania losowych identyfikatorów . Chociaż tego typu zasoby często mają bardziej marginalny cel niż te zarządzające „prawdziwymi” obiektami infrastruktury, mogą być przydatne jako spoiwo pomagające łączyć ze sobą inne zasoby.

Zachowanie zasobów dostępnych wyłącznie lokalnie jest takie samo jak wszystkich innych zasobów, ale dane dotyczące ich wyników istnieją tylko w stanie Terraform. „Zniszczenie” takiego zasobu oznacza jedynie usunięcie go ze stanu, usunięcie jego danych.

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/007_resources_local/digitalocean_example/graph.png "Przykład graficzny konfiguracji")