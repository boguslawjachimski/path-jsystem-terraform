#!/bin/bash
# Inicjalizacja konfiguracji Terraforma
terraform init
echo " "
echo " "
# Sprawdzenie poprawności składni kodu Terraforma
terraform validate
echo " "
echo " "
# Formatowanie kodu Terraforma
terraform fmt -recursive
echo " "
echo " "
# Sprawdzenie poprawności składni kodu Terraforma
terraform plan
echo " "
echo " "
# Graph
terraform graph -type=plan | dot -Tpng > graph.png
read -p "Press enter to continue or CTRL+C to abort"
read -p "Now we run terraform apply (this generate \$\$\$ in your infrastrukture) or CTRL+C to abort"
# Uruchomienie kodu Terraforma
terraform apply -auto-approve
echo " "
echo " "
read -p "Now we run terraform destroy (this destroy your infrastrukture (SAVE MONEY :)) or CTRL+C to abort"
# Usunięcie kodu Terraforma
terraform destroy -auto-approve

# Graph
terraform graph -type=plan | dot -Tpng > graph.png
#terraform plan -out=plan && terraform show -json plan > plan.tfgraph