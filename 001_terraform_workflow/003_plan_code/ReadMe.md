# Terraform plan
Możemy użyć `terraform plan` lub `terraform plan -out=plan.out` - aby zapisać plan do pliku i zweryfikować go.

Samo polecenie `terraform apply` działa podobnie jak `terraform plan` tez wyświetla nam podsumowanie, tu dodatkowo mamy interakcje w postaci akceptacji zmian. Terraform z naszym planem z pliku `terraform apply plan.out` - Wykona nasz plan z pliku.

Dla usunięcia całego środwiska `terraform destroy` lub `terraform destroy plan.out` - dla usuniecia zmiany z wprowadzanego pliku plan.

`terraform plan -target=digitalocean_project.student_projekt` - to plan dla pojedynczego zasobu.