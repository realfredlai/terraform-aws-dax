# AWS DynamoDB Accelerator (DAX) module
Terraform module to create AWS DAX clusters resources with features provided by Terraform AWS provider.

## Usage

```hcl
module "dax" {
  source = "realfredlai/dax/aws"

  name               = "dax-example"
  subnet_ids         = ["subnet-xxx", "subnet-xxx", "subnet-xxx"]
  policy_statements  = {
    dynamodb = {
      effect = "Allow",
      actions = ["dynamodb:*"],
      resources = ["*"]
    },
  }
  security_group_ids = ["sg-xxx"]
}
```

## Examples

- [Basic example](https://github.com/realfredlai/terraform-aws-dax/tree/main/examples/basic)
- [Complete example](https://github.com/realfredlai/terraform-aws-dax/tree/main/examples/complete)
- [Reuse existing IAM role example](https://github.com/realfredlai/terraform-aws-dax/tree/main/examples/with-existing-iam-role)
- [Reuse existing parameter group example](https://github.com/realfredlai/terraform-aws-dax/tree/main/examples/with-existing-parameter-group)
- [Reuse existing subnet group example](https://github.com/realfredlai/terraform-aws-dax/tree/main/examples/with-existing-subnet-group)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dax_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_cluster) | resource |
| [aws_dax_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_parameter_group) | resource |
| [aws_dax_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_subnet_group) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_encryption_type"></a> [cluster\_endpoint\_encryption\_type](#input\_cluster\_endpoint\_encryption\_type) | The type of encryption in the cluster's endpoint. One of: NONE, TLS. | `string` | `"TLS"` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Whether or not to create a parameter group for the cluster. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the DAX cluster | `string` | `""` | no |
| <a name="input_enable_server_side_encryption"></a> [enable\_server\_side\_encryption](#input\_enable\_server\_side\_encryption) | Whether or not to enable encryption at rest using an AWS managed KMS key. | `bool` | `true` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | A valid Amazon Resource Name (ARN) that identifies an IAM role. At runtime, DAX will assume this role and use the role's permissions to access DynamoDB on your behalf. If not present, a role will be created, and policy\_statements is required. | `string` | `""` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Specifies the weekly time range for when maintenance on the cluster is performed. | `string` | `"sun:05:00-sun:09:00"` | no |
| <a name="input_name"></a> [name](#input\_name) | Desired name for the DAX | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The compute and memory capacity of the nodes. | `string` | `"dax.t3.small"` | no |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications will be sent. | `string` | `""` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | The description of the parameter group to associate with this DAX cluster. | `string` | `"default.dax1.0"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the parameter group to associate with this DAX cluster. | `string` | `"default.dax1.0"` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | A map of parameters to apply to the parameter group. Only required when create\_parameter\_group is true. | `any` | `{}` | no |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | Map of dynamic policy statements to attach to DAX role | `any` | `{}` | no |
| <a name="input_replication_factor"></a> [replication\_factor](#input\_replication\_factor) | The number of nodes in the DAX cluster. A replication factor of 1 will create a single-node cluster, without any read replicas. | `number` | `3` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | One or more VPC security groups associated with the cluster. | `list(string)` | `[]` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | Description of the subnet group to be used for the cluster. | `string` | `""` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of the subnet group to be used for the cluster. If not present, a subnet group will be created, and subnet\_ids are required. | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Name of the subnet ids to form subnet group to be used for the cluster. Only required when subnet\_group\_name is not present. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the DAX cluster. |
| <a name="output_cluster_address"></a> [cluster\_address](#output\_cluster\_address) | The DNS name of the DAX cluster without the port appended. |
| <a name="output_configuration_endpoint"></a> [configuration\_endpoint](#output\_configuration\_endpoint) | The configuration endpoint for this DAX cluster, consisting of a DNS name and a port number. |
| <a name="output_nodes"></a> [nodes](#output\_nodes) | List of node objects including id, address, port and availability\_zone. |
| <a name="output_port"></a> [port](#output\_port) | The port used by the configuration endpoint. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/LICENSE) for full details.
