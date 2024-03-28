terraform {
  cloud {
    organization = "piotrkoska"

    workspaces {
      name = "test"
    }
  }
}