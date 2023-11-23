# Metaargument count

Domyślnie blok zasobów konfiguruje jeden rzeczywisty obiekt infrastruktury. (Podobnie blok modułu jednorazowo włącza do konfiguracji zawartość modułu podrzędnego). Czasami jednak chcesz zarządzać kilkoma podobnymi obiektami (np. stałą pulą instancji obliczeniowych) bez pisania osobnego bloku dla każdego z nich. Terraform może to zrobić na dwa sposoby: count i for_each.

Jeśli blok zasobu lub modułu zawiera count argument, którego wartość jest liczbą całkowitą, Terraform utworzy odpowiednią liczbę instancji.

## Zadanie 1: Metaargument count
Dodaj prosze parametr `count` do zasobu `digitalocean_droplet` i jako wartość podaj `2`.