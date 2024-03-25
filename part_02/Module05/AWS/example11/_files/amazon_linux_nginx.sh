#!/bin/bash

# Aktualizuj zainstalowane pakiety i pakiet menedżera
sudo yum update -y

# Włącz repozytorium Amazon Linux Extra, aby zainstalować Nginx
sudo amazon-linux-extras install -y nginx1

# Uruchom serwer Nginx
sudo systemctl start nginx

# Włącz Nginx, aby uruchamiał się przy starcie systemu
sudo systemctl enable nginx

# Sprawdź, czy Nginx jest zainstalowany i uruchomiony poprzez wyświetlenie statusu usługi
sudo systemctl status nginx | grep active
