check "name_quality_check_ver1" {
  assert {
    condition     = !strcontains(aws_lambda_function.test_lambda.function_name, "hello-world")
    error_message = "Hello world functions are not allowed in production"
  }
}

check "name_quality_check_ver2" {
  assert {
    condition     = !strcontains(aws_lambda_function.test_lambda.function_name, "hello-world")
    error_message = "Hello world functions are not allowed in production. Your function is named: ${aws_lambda_function.test_lambda.function_name}"
  }
}

check "latest_lambda_runtime_ver1" {
  assert {
    condition     = aws_lambda_function.test_lambda.runtime == "python3.8"
    error_message = "Please upgrade from ${aws_lambda_function.test_lambda.runtime} to python3.10"
  }
}

check "latest_lambda_runtime_ver2" {
  assert {
    condition     = contains(["python3.12", "python3.11"], aws_lambda_function.test_lambda.runtime)
    error_message = "Please upgrade from ${aws_lambda_function.test_lambda.runtime} to python3.11 or python3.12"
  }
}

check "cost_centre_tags_on_all_resources" {
  assert {
    condition = (
      can(aws_lambda_function.test_lambda.tags_all["product-name"]) &&
      can(aws_lambda_function.test_lambda.tags_all["cost-centre"])
    )
    error_message = "Please add tags for cost allocation. Your tags must include 'cost-centre' and 'product-name'"
  }
}