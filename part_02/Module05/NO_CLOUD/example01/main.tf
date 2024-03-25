resource "local_file" "localfile01" {
  content = "This is a local file"
  filename = "${path.root}/file01.txt"
}

resource "local_file" "localfile02" {
  content = "This is a local file"
  filename = "${path.cwd}/file02.txt"
}

resource "local_file" "localfile03" {
  content = "This is a local file"
  filename = "${path.module}/file02.txt"
}