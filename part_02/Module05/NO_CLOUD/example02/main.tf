variable "filename" {
  default = "index.html"
}

variable "facts" {
  default = ["fun","hard"]
}

variable "complex_facts" {
  default = [{element: "h2", content: "FUN!"},{element: "h3", content: "HARD!"}]
}

variable "content" {
  default = "Terraform"
}

resource "local_file" "index" {
  filename = "${terraform.workspace}-${var.filename}.txt" # defult-index.html.txt
  content  = "foo!"
}

resource "local_file" "index_html" {
  filename = "${path.module}/${var.filename}" # ./index.html
  content  = <<EOT
<html>
    %{for fact in var.facts}
      <p>Terraform is ${fact} ${terraform.workspace}</p>
    %{endfor}

    %{for fact in var.complex_facts}
      <${fact.element}>Terraform is ${fact.content} ${terraform.workspace}</${fact.element}>
    %{endfor}
</html>
  EOT
}

resource "local_file" "txt1" {
  filename = "${path.module}/${terraform.workspace}-file1.txt" # ./defult-file1.txt
  content  = <<EOT
    ${ var.content != "" ? var.content : "NO CONTENT PROVIDED"}
  EOT
}

resource "local_file" "txt2" {
  filename = "${path.module}/${terraform.workspace}-file2.txt" # ./defult-file2.txt
  content  = <<EOT
    %{ if var.content != "" }${var.content}%{ else }NO CONTENT PROVIDED!%{ endif }
  EOT
}