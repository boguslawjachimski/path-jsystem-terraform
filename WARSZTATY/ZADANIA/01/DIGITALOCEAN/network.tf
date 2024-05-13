resource "digitalocean_vpc" "main" {
    name = "tf-piotrkoskatestc-temp-vpc"
    region = "fra1"
    ip_range = "10.113.113.0/24"

    #depends_on = [ local_file.key ]
}