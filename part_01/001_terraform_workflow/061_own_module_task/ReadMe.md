# Zadanie:

Zadanie polega na napisaniu własnego mogułu w terraform.
Moduł ten bedzie tworzył:
 - X liczbe maszyn wirtualnych - jak osobny moduł.
 - przygotuj też sieci pod te maszyny wirtualne. Siec tworzona pod maszynę wirtualna niech bedzie realizowana przez osobny moduł.
 - Obie maszyny wirtualne bedą miały konfiguracje firewall z podziałem na public i managment.
    - Porty otwarte na public to 80 i 443.
    - Porty z restrykcjami managment dla Twojego IP pdla portu 22.
    - Ruch po miedzy maszynami wirtualnymi powinien byc dozwolony.
- Na jednej maszynie niech działa WWW i wysietla witaj 1.
- Na drugiej maszynie niech działa WWW i wysietla witaj 2.
- Połaczenie do maszyny wirtualnej niech odbywa sie przez klucz prywatny (wygeneruj klucz).
- Pobierz infromacje o adresach IP maszyn wirtualnych i wyświetl je w konsoli. Tak by sprawdzić czy strony www działają.