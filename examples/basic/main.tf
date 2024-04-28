resource "aws_security_group" "dax" {
  name        = "dax-sg-basic"
  description = "Allow DAX inbound traffic"
  vpc_id      = "vpc-xxx" # The vpc id

  ingress {
    description = "Encrypted in transit"
    from_port   = 9111
    to_port     = 9111
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "dax" {
  source = "../../"

  name       = "dax-example-basic"
  subnet_ids = ["subnet-xxx", "subnet-xxx", "subnet-xxx"] # Subnets are required when subnet_group_name is not present.
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:*"],
      resources = ["*"]
    },
  }
  security_group_ids = [aws_security_group.dax.id]
}
