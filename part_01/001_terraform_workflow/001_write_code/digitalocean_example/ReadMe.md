# Głowne pliki terraform
1. Plik version.tf zawiera konfiguracje naszego terraform oraz providera 
2. Plik providers.tf zawiera konfiguracje naszego providera (digitalocean)
3. Plik .auto.tfvars zawiera konfiguracje naszego tokenu do digitalocean (wklej swój token do zmiennej do_token).
4. Plik main.tf zawiera konfiguracje naszej infrastruktury (project i vpc).

## Dodatkowe pliki:
1. Plik graph.png zawiera graficzny obraz naszej infrastruktury (użyj `terraform graph -type=plan | dot -Tpng > graph.png`).
2. archive.sh zawiera skrypt do archiwizacji plików terraform (używaj `./archive.sh` aby uruchomić).
3. run.sh zawiera skrypt do uruchomienia plików terraform (używaj `./run.sh` aby uruchomić).