resource "aws_security_group" "dax" {
  name        = "dax-sg"
  description = "Allow DAX inbound traffic"
  vpc_id      = "vpc-xxx" # The vpc id

  ingress {
    description = "Unencrypted in transit"
    from_port   = 8111
    to_port     = 8111
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Encrypted in transit"
    from_port   = 9111
    to_port     = 9111
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dax-sg"
  }
}

module "dax" {
  source = "../../"

  name        = "dax-example-iam"
  description = "DAX to DynamoDB example"

  node_type                = "dax.t3.small"
  subnet_group_description = "Example subnet group"
  subnet_ids               = ["subnet-xxx", "subnet-xxx", "subnet-xxx"]       # Subnets are required when subnet_group_name is not present.
  iam_role_arn             = "arn:aws:iam::123456789:role/DaxtoDynamoDB-Role" # If not present, a role will be created, and policy_statements is required.
  # policy_statements = {
  #   dynamodb = {
  #     effect = "Allow",
  #     actions = [
  #       "dynamodb:BatchGetItem",
  #       "dynamodb:GetItem",
  #       "dynamodb:Query",
  #       "dynamodb:Scan",
  #       "dynamodb:BatchWriteItem",
  #       "dynamodb:DeleteItem",
  #       "dynamodb:PutItem",
  #       "dynamodb:UpdateItem",
  #       "dynamodb:DescribeLimits",
  #       "dynamodb:DescribeTimeToLive",
  #       "dynamodb:DescribeTable",
  #       "dynamodb:ListTables"
  #     ],
  #     resources = [
  #       "arn:aws:dynamodb:us-west-2:123456789:table/db-name" # Specify the table name
  #     ]
  #   },
  # }
  security_group_ids          = [aws_security_group.dax.id]
  create_parameter_group      = true
  parameter_group_description = "Example parameter group"
  parameter_group_parameters = {
    query = {
      name  = "query-ttl-millis"
      value = "300000"
    }
    record = {
      name  = "record-ttl-millis"
      value = "300000"
    }
  }
  maintenance_window = "sun:12:00-sun:13:00"
  tags = {
    Name  = "dax-example",
    Owner = "Fred"
  }
}
