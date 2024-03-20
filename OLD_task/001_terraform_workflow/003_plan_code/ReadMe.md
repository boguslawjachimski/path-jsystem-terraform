# Terraform plan
Polecenie terraform plan ma na celu wygenerowanie planu zmian, które zostaną wprowadzone do infrastruktury. Terraform plan nie wprowadza zmian do infrastruktury, tylko wyświetla podsumowanie zmian, które zostaną wprowadzone.

Możemy użyć `terraform plan` lub `terraform plan -out=plan.out` aby zapisać plan do pliku.

Samo polecenie `terraform apply` działa podobnie jak `terraform plan` też wyświetla nam podsumowanie, tu dodatkowo mamy interakcje w postaci akceptacji zmian i działania na naszej infrastrukturze. 

Terraform z naszym planem z pliku `terraform apply plan.out` - Wykona nasz plan z pliku dokładnie taki jaki został wygenerowany.

Polecenia terraform plan i terraform apply generują i akceptuja plan spekulacyjny, który może być nieaktualny, jeśli nie został wygenerowany od ostatniego terraform refresh. Terraform refresh aktualizuje stan lokalny, aby odzwierciedlić rzeczywisty stan zasobów. Terraform refresh nie wprowadza zmian do infrastruktury, ale aktualizuje stan lokalny, aby odzwierciedlić rzeczywisty stan zasobów.

Dla usunięcia całego środwiska `terraform destroy` lub `terraform destroy plan.out` - dla usuniecia zmiany z wprowadzanego pliku plan.

`terraform plan -target=digitalocean_project.student_projekt` - to plan dla pojedynczego zasobu.