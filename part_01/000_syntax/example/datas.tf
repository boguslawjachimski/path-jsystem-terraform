data "data_type" "data_name" {
  # ...
}
/*
Głównym celem bloku danych jest ładowanie lub wysyłanie zapytań 
o dane z interfejsów API innych niż Terraform. Można go wykorzystać 
do zapewnienia elastyczności konfiguracji lub połączenia różnych 
obszarów roboczych. Jednym ze sposobów wykorzystania bloków danych 
jest zapytanie do interfejsu API w celu uzyskania listy aktywnych 
stref dostępności, w których można wdrożyć zasoby.

Dostęp do danych jest następnie uzyskiwany przy użyciu notacji kropkowej.
*/