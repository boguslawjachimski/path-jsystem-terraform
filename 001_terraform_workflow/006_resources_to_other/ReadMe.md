# Dostęp do atrybutów zasobów

Wyrażenia w module Terraform mogą uzyskać dostęp do informacji o zasobach w tym samym module, a Ty możesz użyć tych informacji do skonfigurowania innych zasobów. Użyj tej `<RESOURCE TYPE>.<NAME>.<ATTRIBUTE>` składni, aby odwoływać się do atrybutu zasobu w wyrażeniu.

Oprócz argumentów określonych w konfiguracji zasoby często udostępniają atrybuty tylko do odczytu z informacjami uzyskanymi ze zdalnego interfejsu API; często obejmuje to rzeczy, których nie można poznać przed utworzeniem zasobu, na przykład unikalny losowy identyfikator zasobu.

Wielu dostawców uwzględnia także źródła danych , które stanowią specjalny rodzaj zasobów wykorzystywanych wyłącznie do wyszukiwania informacji.

Aby zapoznać się z listą atrybutów udostępnianych przez typ zasobu lub źródła danych, zapoznaj się z jego dokumentacją; są one zazwyczaj zawarte na drugiej liście poniżej listy konfigurowalnych argumentów.

## Zadanie 1: Dostęp do atrybutów zasobów
Naszym zadaniem bedzie wykorzystanie atrybutów zasobów do konfiguracji innych zasobów.
W naszej konfiguracji mamy zasób `digitalocean_vpc` który tworzy nam prywatną sieć w naszym środowisku. Odwołajmy sie do tej sieci i wykorzystajmy jej atrybuty do konfiguracji zasobu `digitalocean_droplet` który tworzy nam maszynę wirtualną.

## Plan infrastruktury:
![PNG GRAPH](/001_terraform_workflow/006_resources_to_other/digitalocean_example/graph.png "Przykład graficzny konfiguracji")