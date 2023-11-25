locals {
  bucket_name = "mytest"
  env         = "dev"
}

locals {
  env_tags = {
    envname = "dev"
    envteam = "devteam"
  }
}