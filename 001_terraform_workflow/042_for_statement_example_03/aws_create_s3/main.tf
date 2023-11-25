resource "aws_s3_bucket" "my_bucket" {
  bucket = "moj-unikalny-nazwa-bucket"  # Unikalna nazwa bucketu
  acl    = "private"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "myusers/users.json"
  source = "${path.cwd}/_files/users.json"  # Ścieżka do pliku JSON
  acl    = "private"
  content_type = "application/json"
  metadata = {
    "content-type" = "application/json"
  }
}