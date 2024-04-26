################################################################################
# DAX
################################################################################

locals {
  subnet_group_name    = var.subnet_group_name != "" ? var.subnet_group_name : aws_dax_subnet_group.this[0].name
  iam_role_arn         = var.iam_role_arn != "" ? var.iam_role_arn : aws_iam_role.this[0].arn
  parameter_group_name = var.create_parameter_group ? aws_dax_parameter_group.this[0].name : var.parameter_group_name
  tags = merge(
    {
      Name      = var.name
      ManagedBy = "terraform"
    },
    var.tags
  )
}

################################################################################
# Networks
################################################################################
resource "aws_dax_subnet_group" "this" {
  count = var.subnet_group_name != "" ? 0 : 1

  name        = join("-", [var.name, "dax", "subgrp"])
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids
}

################################################################################
# Security
################################################################################
resource "aws_iam_role" "this" {
  count = var.iam_role_arn != "" ? 0 : 1

  name = join("-", [var.name, "DaxtoDynamoDB", "Role"])

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dax.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.iam_role_arn != "" ? 0 : 1

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.this[0].arn
}

resource "aws_iam_policy" "this" {
  count = var.iam_role_arn != "" ? 0 : 1

  name   = join("-", [var.name, "dax", "policy"])
  policy = data.aws_iam_policy_document.this[0].json

  tags = local.tags
}

data "aws_iam_policy_document" "this" {
  count = var.iam_role_arn != "" ? 0 : 1

  dynamic "statement" {
    for_each = var.policy_statements

    content {
      sid           = try(statement.value.sid, replace(statement.key, "/[^0-9A-Za-z]*/", ""))
      effect        = try(statement.value.effect, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])
        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.condition, [])
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

################################################################################
# Advanced settings
################################################################################
resource "aws_dax_parameter_group" "this" {
  count = var.create_parameter_group ? 1 : 0

  name        = join("-", [var.name, "dax", "paramgrp"])
  description = var.parameter_group_description

  dynamic "parameters" {
    for_each = var.parameter_group_parameters
    content {
      name  = parameters.value.name
      value = parameters.value.value
    }
  }
}

resource "aws_dax_cluster" "this" {
  # Cluster
  cluster_name       = var.name
  description        = var.description
  node_type          = var.node_type
  replication_factor = var.replication_factor

  # Networks
  subnet_group_name  = local.subnet_group_name
  security_group_ids = var.security_group_ids

  # Security
  iam_role_arn = local.iam_role_arn
  server_side_encryption {
    enabled = var.enable_server_side_encryption
  }
  cluster_endpoint_encryption_type = var.cluster_endpoint_encryption_type

  # Advanced settings
  parameter_group_name   = local.parameter_group_name
  maintenance_window     = var.maintenance_window
  notification_topic_arn = var.notification_topic_arn

  tags = local.tags
}
