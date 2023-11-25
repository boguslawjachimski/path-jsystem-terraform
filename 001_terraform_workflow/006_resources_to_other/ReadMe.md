# Dostęp do atrybutów zasobów

Wyrażenia w module Terraform mogą uzyskać dostęp do informacji o zasobach w tym samym module, a Ty możesz użyć tych informacji do skonfigurowania innych zasobów. Użyj tej `<RESOURCE TYPE>.<NAME>.<ATTRIBUTE>` składni, aby odwoływać się do atrybutu zasobu w wyrażeniu.

Oprócz argumentów określonych w konfiguracji zasoby często udostępniają atrybuty tylko do odczytu z informacjami uzyskanymi ze zdalnego interfejsu API; często obejmuje to rzeczy, których nie można poznać przed utworzeniem zasobu, na przykład unikalny losowy identyfikator zasobu.

Wielu dostawców uwzględnia także źródła danych , które stanowią specjalny rodzaj zasobów wykorzystywanych wyłącznie do wyszukiwania informacji.

Aby zapoznać się z listą atrybutów udostępnianych przez typ zasobu lub źródła danych, zapoznaj się z jego dokumentacją; są one zazwyczaj zawarte na drugiej liście poniżej listy konfigurowalnych argumentów.

## Zadanie 1: Dostęp do atrybutów zasobów
Naszym zadaniem bedzie wykorzystanie atrybutu innego zasobów do konfiguracji innych naszego zasobu.
W naszej konfiguracji mamy zasób `digitalocean_vpc`, który tworzy nam prywatną sieć w naszym środowisku. 
- Odwołajmy sie do tej sieci i wykorzystajmy jej atrybuty do konfiguracji zasobu `digitalocean_droplet` który tworzy nam maszynę wirtualną.
- Odwoloac sie do zasobu mozemy po przez <RESOURCES>.<NAME>.<ATTRYBUT>

```hcl
...
# Maszyna wirtualna
resource "digitalocean_droplet" "student_droplet" {
  name = "stf-pio-kos-development-fra1-droplet"
  region = "fra1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-20-04-x64"
  vpc_uuid = digitalocean_vpc.student_network.id # Referencja do VPC
  tags = ["stf","piotr_koska"]

  timeouts {
    create = "50s"
    update = "100s"
    delete = "30s"
  }
}
```

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/006_resources_to_other/digitalocean_example/graph.png "Przykład graficzny konfiguracji")