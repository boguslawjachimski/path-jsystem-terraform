# Terraform

## IaC - Infrastructure as Code
links:
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code
- https://www.hashicorp.com/blog/infrastructure-as-code-in-a-private-or-public-cloud
- https://www.hashicorp.com/resources/what-is-infrastructure-as-code

## Instalation
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Terraform other version
- https://releases.hashicorp.com/terraform/

1. Create directories to keep the Terraform binaries
```bash
$ mkdir -p /usr/local/tf
$ mkdir -p /usr/local/tf/11
$ mkdir -p /usr/local/tf/12
```
2. Download the binaries for both the versions
    2.1. Download and extract the binary for Terraform 0.11 in a separate directory:
```bash
$ cd /usr/local/tf/11
$ wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
$ unzip terraform_0.11.14_linux_amd64.zip
$ rm terraform_0.11.14_linux_amd64.zip
```
2.2 Download and extract the binary for Terraform 0.12 in a separate directory:
```bash
$ cd /usr/local/tf/12
$ wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
$ unzip terraform_0.12.20_linux_amd64.zip
$ rm terraform_0.12.20_linux_amd64.zip
```
2.3 Create symlinks for both the Terraform versions in /usr/bin/ directory:
```bash
ln -s /usr/local/tf/11/terraform /usr/bin/terraform11
ln -s /usr/local/tf/12/terraform /usr/bin/terraform12

# Make both the symlinks executable
chmod ugo+x /usr/bin/terraform*
```
3. Calling different versions
Now, command terraform11 invokes version 0.11 and terraform12 invokes version 0.12
```bash
$ terraform11
$ terraform12
```


### OpenTofu

Dodatkowa informacj o opentofu - 

https://www.youtube.com/channel/UCgIzfj9QuWL9HHXIXq2A0Ig

szyfrowany stan https://www.youtube.com/watch?v=rR4IbhlRSkI