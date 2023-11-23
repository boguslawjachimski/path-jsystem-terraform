Choc juz pracowalismy z zasobami to w ramach tej lekcji omwimy sobie jak mozemy pracowac z zasaobami oraz jakie akcje oraz dodatkowe argumenty one posiadają.

- w tym zadaniu dodamy naszą maszyne wirtualną do naszego kodu terraform
    - name = nazwa maszyny wirtualnej niech zaczyna sie od `sft-<twoje inicjały(trzylitery imienia i nazwiska)>-vm`
    - image = "ubuntu-20-04-x64"
    - region = "fra1"
    - size = "s-1vcpu-1gb"
    - tags = "stf, `<imie_nazwisko>`"