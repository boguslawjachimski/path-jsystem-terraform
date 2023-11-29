resource "local_file" "index" {
  filename = "${var.filename}.txt"
  content  = "foo!"
}

variable "filename" {
  default = "index.html"
}

variable "facts" {
  default = ["fun", "hard"]
}

variable "complex_facts" {
  default = [
    {
      element: "h2"
      content: "FUN!"
    },
    {
      element: "h1"
      content: "EASY!"
    }
  ]
}

resource "local_file" "index_html" {
  filename = "${path.module}/${var.filename}"
  content  = <<EOT
    <html>
    %{for fact in var.facts}
      <p>Terraform is ${fact}</p>
    %{endfor}

    %{for fact in var.complex_facts}
      <${fact.element}>Terraform is ${fact.content}</${fact.element}>
    %{endfor}
    </html>
  EOT
}

variable "content" {
  default = "Terraform"
}

resource "local_file" "txt1" {
  filename = "${path.module}/file1.txt"
  content  = <<EOT
    ${ var.content != "" ? var.content : "NO CONTENT PROVIDED"}
  EOT
}

resource "local_file" "txt2" {
  filename = "${path.module}/file2.txt"
  content  = <<EOT
    %{ if var.content != "" }${var.content}%{ else }NO CONTENT PROVIDED!%{ endif }
  EOT
}