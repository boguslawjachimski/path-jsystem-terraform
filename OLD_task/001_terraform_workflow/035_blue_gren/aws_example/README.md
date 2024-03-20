https://developer.hashicorp.com/terraform/tutorials/aws/blue-green-canary-tests-deployments

```bash
for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done
```

1. Deploy green environment
`green.tf`

```hcl
resource "aws_instance" "green" {
  count = var.enable_green_env ? var.green_instance_count : 0

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)]
  vpc_security_group_ids = [module.app_security_group.security_group_id]
  user_data = templatefile("${path.module}/init-script.sh", {
    file_content = "version 1.1 - #${count.index}"
  })

  tags = {
    Name = "green-${count.index}"
  }
}

resource "aws_lb_target_group" "green" {
  name     = "green-tg-${random_pet.app.id}-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "green" {
  count            = length(aws_instance.green)
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.green[count.index].id
  port             = 80
}
```

2. add to variables.tf
```hcl
variable "enable_green_env" {
  description = "Enable green environment"
  type        = bool
  default     = true
}

variable "green_instance_count" {
  description = "Number of instances in green environment"
  type        = number
  default     = 2
}
```

3. 

```bash
for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done
```

add to variables.tf
```hcl
locals {
  traffic_dist_map = {
    blue = {
      blue  = 100
      green = 0
    }
    blue-90 = {
      blue  = 90
      green = 10
    }
    split = {
      blue  = 50
      green = 50
    }
    green-90 = {
      blue  = 10
      green = 90
    }
    green = {
      blue  = 0
      green = 100
    }
  }
}

variable "traffic_distribution" {
  description = "Levels of traffic distribution"
  type        = string
}
```

terraform apply -var 'traffic_distribution=blue-90'
terraform apply -var 'traffic_distribution=split'
terraform apply -var 'traffic_distribution=green'

```bash
for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done
```

terraform apply -var 'traffic_distribution=green' -var 'enable_blue_env=false'

terraform apply -var 'traffic_distribution=green'

terraform apply -var 'traffic_distribution=green-90'

terraform apply -var 'traffic_distribution=blue'