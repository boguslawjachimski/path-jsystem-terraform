# Plik z zmiennymi zazwyczaj zawiera on wszystkie zmienne w ramach danego projektu / środowiska / modułu.

# Zmienna "do_token" jest wymagana do połączenia się z DigitalOcean API.
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}