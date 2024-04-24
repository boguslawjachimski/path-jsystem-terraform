# Zadania Terraform

## Cwiczenia
W ramach Cwiczeń i utrwalenia wiedzy wykonamy kilka zadań związanych z Terraformem.

### Zadanie 1
Wykorzystując variables stwórz konfigurację zasobu który uruchomi maszynę wirtualną w chmurze digitalocean do której bedziesz mógł sie zalogować po przez klucz SSH generowanym rownież z terraform. Wejscia do naszego root modułu to:
- Nazwa maszyny wirtualnej.
- Region tej maszyny wirtualnej.
- Miejsce zapisu naszego klucza ssh na dysku lokalnym. 

### Zadanie 2
Wykorzystując count i for_each skonfiguruj za pomoca count dwie takie same maszyny wirtualne w chmurze digitalocean. Niech te maszyny wirtualne bedą podpiete do danego projektu (digitalocean_project) oraz do danego tagu (digitalocean_tag). Dla konfiguracji for_each niech każda maszyna wirtualna bedzie inna (posiadała inna konfigurację). Uzyj zmiennej i wartości z pliku.

### Zadanie 3
Wykorzystując terraform workspace przygotuj konfiguracje ktora tworzy maszyne wirtualna dla srodwiska dev i prod. W dev potrzebujemy tylko jedną maszynę w prod 3 maszyny wirtualne.

### Zadanie 4
Dla wszystkich regionów w digitalo ocena stworz sieci z adresacji 192.168.X.X/16 dzieląc ja na odpowiednie podsieci tak by nie było konfliktów i każdy region miał swoją sieć. Wykorzystaj variables (mapa/obiect) oraz instrukcje for do kostrukcji sieci.

### Zadanie 5
Przygotuj konfiguracje w digitalo ocean ktora bedzie dla maszyn wirtualnych tworzyć regułę firewall pozwalająca na ruch tylko na porcie 80 i 443 (22 bedzie dozwolone tylko z twojego IP). Wykorzystaj dynamiczne bloki konfiguracyjne.

### Zadanie 6
Przygotuj konfiguracje która to wykorzysta inny terraform state i pobierze informacje o adresach IP prywatnym i publicznym maszyn wirtualnych z innego pliku terraform state w innej twojej konfiguracji.
