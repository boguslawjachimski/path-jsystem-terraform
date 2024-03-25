#!/bin/bash

# Aktualizuj listę pakietów
sudo apt-get update

# Instaluj Nginx
sudo apt-get install -y nginx

# Sprawdź, czy Nginx jest zainstalowany poprzez wyświetlenie statusu usługi
sudo systemctl status nginx | grep active

# Jeśli Nginx jest aktywny, wydrukuj komunikat potwierdzający
if [ $? -eq 0 ]; then
    echo "Nginx został pomyślnie zainstalowany i uruchomiony."
else
    echo "Wystąpił problem z instalacją Nginx."
fi

sudo cp -f /tmp/index.html /var/www/html/index.html