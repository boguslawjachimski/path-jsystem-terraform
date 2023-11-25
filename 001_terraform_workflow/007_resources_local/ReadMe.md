# Zasoby dostępne wyłącznie lokalnie

Chociaż większość typów zasobów odpowiada typowi obiektu infrastruktury zarządzanego za pośrednictwem zdalnego interfejsu API sieci, istnieją pewne wyspecjalizowane typy zasobów, które działają tylko w samym Terraformie, obliczając niektóre wyniki i zapisując je w stanie do wykorzystania w przyszłości.

Na przykład istnieją typy zasobów dostępne wyłącznie lokalnie, które służą do generowania kluczy prywatnych , wydawania samopodpisanych certyfikatów TLS , a nawet generowania losowych identyfikatorów . Chociaż tego typu zasoby często mają bardziej marginalny cel niż te zarządzające „prawdziwymi” obiektami infrastruktury, mogą być przydatne jako spoiwo pomagające łączyć ze sobą inne zasoby.

Zachowanie zasobów dostępnych wyłącznie lokalnie jest takie samo jak wszystkich innych zasobów, ale dane dotyczące ich wyników istnieją tylko w stanie Terraform. „Zniszczenie” takiego zasobu oznacza jedynie usunięcie go ze stanu, usunięcie jego danych.

## Zadanie:
Do naszej poprzedniej konfiguracji dodajmy plik `ssh_key.tf` - dla terraform nie ma znaczenia ile jest plików. Terraform scala podczas pracy z plikami je w jeden wielki kod. Rozdzielenie na pliki słuzy jedynie dla nas w celu łatwiejszej nawigacji i konfiguracji naszego projektu.

- Dodajmy zatem nasz plik `ssh_key.tf` z kodem:

```hcl
resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Zdalny zasob digitalocean - dodanie klucza ssh.
resource "digitalocean_ssh_key" "student_ssh_key" {
  name = "stf-pio-kos-development-fra1-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}
```

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/007_resources_local/digitalocean_example/graph.png "Przykład graficzny konfiguracji")