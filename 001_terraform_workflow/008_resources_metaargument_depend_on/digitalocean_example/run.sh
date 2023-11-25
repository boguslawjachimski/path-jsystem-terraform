#!/bin/bash
terraform init; 
terraform plan; 
terraform graph -type=plan | dot -Tpng > graph.png; 
#terraform apply -auto-approve; 
#terraform destroy -auto-approve