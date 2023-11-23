# Provisioner
Można używać dostawców usług do modelowania określonych działań na komputerze lokalnym lub na komputerze zdalnym w celu przygotowania serwerów lub innych obiektów infrastruktury do obsługi.

1. Dostawcy zasobów to ostateczność
2. Przekazywanie danych do maszyn wirtualnych i innych zasobów obliczeniowych
    1. Lepiej wykorzystać cloud-init
3 Obiekt `self`

## Obiekt self_
Wyrażenia w `provisioner`blokach nie mogą odnosić się do zasobu nadrzędnego po nazwie. Zamiast tego mogą użyć specjalnego `self`obiektu.

Obiekt `self`reprezentuje zasób nadrzędny dostawcy usług i ma wszystkie atrybuty tego zasobu. Na przykład użyj, `self.public_ip`aby odwołać się do atrybutu `aws_instance.public_ip`.

## Wielu dostawców
W zasobie można określić wielu dostawców. Wiele dostawców usług jest wykonywanych w kolejności określonej w pliku konfiguracyjnym.

## Zachowanie niepowodzenia
Domyślnie dostawcy, którzy zawiodą, spowodują również awarię samego Terraforma. Za pomocą tego ustawienia `on_failure`można to zmienić. 

## Blok połączeń
1. local-exec
2. remote-exec
3. file