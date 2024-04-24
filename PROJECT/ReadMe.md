# Projekt z wykorzystaniem terraform:
W ramach tergo zadania projektowego stworzymu wspolnie razem moduł - do tworzenia naszej infrastruktury z wykorzstaniem terraform.

## IaC - Infrastructure as Code

### Zadanie numer 0:
Podlącz konfiguracje terraform state do stanu zdalnego. W tym celu wykorzystaj pg backend lub remote backend.

### Zadanie numer 1:
Nasze pierwsze zadanie bedzie polegalo na stworzeniu modułu ktory jest odpowiedzialny za stworzenie sieci VPC w naszej chmurze digitalocean. Adres ktory mamy do dyspozycji to 10.X.0.0/16 (Wybierz drugi oktet (X) pamietajac ze pracujemy na naszym cloud wspolnie - zaczynajac od 100) W digitalocean mamy nastepujace regiony:
1. NYC1
2. NYC2
3. NYC3
4. SFO1
5. SFO2
6. SFO3
7. FRA1
8. AMS2
9. AMS3
10. SGP1
11. LON1
12. TOR1
13. BLR1
14. SYD1
Podziel po równo naszą siec 10.X.0.0/16 na poszczególne podsieci dla kazdego regionu. 
Wykorzstaj w tym celu locals, for_each, funkcje cidrsubnet, slice, length bloki variable, resorces, output - oraz inne potrzebne (opcjonalna lista sugerowana). 
Siec nazwij swoim imieniem i nazwiskiem.

### Zadanie numer 2:
Nasze drugie zadanie bedzie polegalo na stworzeniu modulu ktory uruchomi jedna instancji w danym regionie (fra1). Wraz z konfiguracja firewall dla tej maszyny wirtualnej:
1. zezwalajac na ruch przychodzacy inbound na porty tcp 22, 80, 443 z sieci 0.0.0.0/0.
2. zezwalajac na ruch przychodzacy inbound na wszystkich portach tcp/udp z sieci lokalnej w ktorej dziala instancja.
3. zezwalajcy na ruch wychodzacy outbound na wszystkich portach tcp/udp do dowolnej sieci 0.0.0.0/0.

Dostep po SSH niech odbywa sie po kluczu generownym dynamicznie przez terraform. Klucz ten mozesz zapisac w postaci pliku jako artefakt naszej konfiguracji.

Wykorzystaj odpowiednie bloki do stworzenia takiej konfiguracji. Wyświetl te dane polaczeniowe do Twojej maszyny wirtualnej w postaci adresu IP.

### Zadanie numer 3:
Dodaj do maszyn wirtualnych konfiguracje za pomoca pliku cloud-init. Niech cloud init instaluje na maszynie wirtualnej serwer www nginx. Serwer www niech wysietla strone www z Twoim imieniem i nazwiskiem po wejsciu na adres IP serwera. Przyglodowy plik nginx.yml znajdziesz w poprzednich Cwiczeniach.
