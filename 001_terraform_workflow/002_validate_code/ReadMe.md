# Validate code
Do walidacji kodu używamy komendy:
```bash
terraform validate
```

Mozna też użyć komendy:
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