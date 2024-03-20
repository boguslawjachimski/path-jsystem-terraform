locals {
    service_name = "example"
    owner = "Piotr Koska"
    instance_type = "t2.micro"
    instance_id = concat(local.service_name, "-", local.owner, "-", local.instance_type)
}

/*
Często nazywany blokiem zmiennych lokalnych. Blok ten służy do 
przechowywania często przywoływanych wartości lub wyrażeń, aby 
zachować czystość i porządek w kodzie.

Blok Locals może przechowywać w środku wiele zmiennych. Wyrażenia 
w wartościach lokalnych nie ograniczają się do stałych literału. 
Mogą także odwoływać się do innych wartości w module, aby je przekształcić 
lub połączyć. Dostęp do tych zmiennych można uzyskać za pomocą 
local.var_namenotacji. Należy pamiętać, że jest ona wywoływana, 
local.gdy jest używana do uzyskiwania dostępu do wartości wewnątrz.
*/