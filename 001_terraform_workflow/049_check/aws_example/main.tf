# IAM role for Lambda
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_hello_world_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Lambda function and archive (.zip) data source
resource "aws_lambda_function" "test_lambda" {
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  function_name    = "hello-world-lambda"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "handler.lambda_handler"
  runtime          = "python3.9"
  tags = {
    "name" = "test-lambda"
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./handler.py"
  output_path = "./handler.zip"
}