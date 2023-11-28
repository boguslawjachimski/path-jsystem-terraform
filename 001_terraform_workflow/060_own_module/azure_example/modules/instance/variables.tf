locals {
  name = "${var.sufix}-${var.name}"
}

variable "region" {
    type = string
    default = "Poland Central"
}

variable "sshkey" {
    type = string
    default = ""
}

variable "name" {
  type = string
  default = "jenkinsserver"
}

variable "sufix" {
  type = string
  default = "stf"
}