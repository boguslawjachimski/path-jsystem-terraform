# Terraform plan
We can use `terraform plan` or `terraform plan -out=plan.out` - to review changes before applying them.

For apply we can use `terraform apply` or `terraform apply plan.out` - to apply changes from plan file.

For destroy we can use `terraform destroy` or `terraform destroy plan.out` - to destroy resources from plan file.

`terraform plan -target=digitalocean_project.student_projekt`` - to plan only one resource.