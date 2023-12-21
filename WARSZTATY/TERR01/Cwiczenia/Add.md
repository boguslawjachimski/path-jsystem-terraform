# Validate code
Do walidacji kodu używamy komendy:
```bash
terraform validate
```

Można też użyć komendy:
```bash
terraform fmt -check
```

Oraz komendy:
```bash
terraform plan
```

Możemy tez wygenerowac schemat blokowy za pomocą komendy:
```bash
terraform graph
```
lub
```bash
terraform graph -type=plan | dot -Tpng > graph.png
terraform plan -out=plan && terraform show -json plan > plan.tfgraph
```


combo write plan, graph apply destroy
```bash
terraform init; terraform plan; terraform graph -type=plan | dot -Tpng > graph.png; terraform apply -auto-approve; terraform destroy -auto-approve
```