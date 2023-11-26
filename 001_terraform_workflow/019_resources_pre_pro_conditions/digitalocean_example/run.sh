#!/bin/bash
terraform init
terraform plan
#terraform apply -auto-approve
#terraform destroy -auto-approve

# Graph
terraform graph -type=plan | dot -Tpng > graph.png
terraform plan -out=plan && terraform show -json plan > plan.tfgraph