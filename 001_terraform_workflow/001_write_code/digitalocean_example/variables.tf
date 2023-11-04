# ten plika zawiera zmienne, które są wykorzystywane w pliku main.tf oraz providers.tf

variable "student" {
  description = "value of student name"
  default     = "student"
}

variable "projekt_name" {
  description = "value of project name"
  default     = "student-project"
}

variable "do_token" {
  description = "value of digitalocean token"
  sensitive   = true
  type        = string
}