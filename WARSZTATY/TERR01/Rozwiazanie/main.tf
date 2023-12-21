# Tworzymy projekt w digitalocean - tu bedziemy alokować nasze zasoby
resource "digitalocean_project" "main" {
  name = ""
  description = "Projekt wykorzystywany w ramach warsztatow z terraform"
  purpose = "Terraform Playground"
  environment = "Development"
}

# Nasz moduł dołaczamy go do projektu
module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    name        = "warsztaty"
    description = "VPC for warsztaty"
    team_account_name = "warsztaty"
    secound_octet = "0"
  }
}

#uzywamy sieci z naszą VM module.vpc.vpc_id["fra1"]