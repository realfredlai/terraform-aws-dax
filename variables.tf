################################################################################
# DAX
################################################################################

variable "name" {
  description = "Desired name for the DAX"
  type        = string
}

variable "description" {
  description = "Description of the DAX cluster"
  type        = string
  default     = ""
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes."
  type        = string
  default     = "dax.t3.small"
}

variable "replication_factor" {
  description = "The number of nodes in the DAX cluster. A replication factor of 1 will create a single-node cluster, without any read replicas."
  type        = number
  default     = 3
}

################################################################################
# Networks
################################################################################

variable "subnet_group_name" {
  description = "Name of the subnet group to be used for the cluster. If not present, a subnet group will be created, and subnet_group_description and subnet_ids are required."
  type        = string
  default     = ""
}

variable "subnet_group_description" {
  description = "Description of the subnet group to be used for the cluster. Only required when subnet_group_name is not present."
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Name of the subnet ids to form subnet group to be used for the cluster. Only required when subnet_group_name is not present."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the cluster."
  type        = list(string)
  default     = []
}

################################################################################
# Security
################################################################################

variable "iam_role_arn" {
  description = "A valid Amazon Resource Name (ARN) that identifies an IAM role. At runtime, DAX will assume this role and use the role's permissions to access DynamoDB on your behalf. If not present, a role will be created, and policy_statements is required."
  type        = string
  default     = ""
}

variable "policy_statements" {
  description = "Map of dynamic policy statements to attach to DAX role"
  type        = any
  default     = {}
}

variable "enable_server_side_encryption" {
  description = "Whether or not to enable encryption at rest using an AWS managed KMS key."
  type        = bool
  default     = true
}

variable "cluster_endpoint_encryption_type" {
  description = "The type of encryption in the cluster's endpoint. One of: NONE, TLS."
  type        = string
  default     = "TLS"
}

################################################################################
# Advanced settings
################################################################################

variable "create_parameter_group" {
  description = "Whether or not to create a parameter group for the cluster."
  type        = bool
  default     = false
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this DAX cluster."
  type        = string
  default     = "default.dax1.0"
}

variable "parameter_group_parameters" {
  description = "A map of parameters to apply to the parameter group. Only required when create_parameter_group is true."
  type        = any
  default     = {}
}

variable "parameter_group_description" {
  description = "The description of the parameter group to associate with this DAX cluster."
  type        = string
  default     = "default.dax1.0"
}

variable "maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cluster is performed."
  type        = string
  default     = "sun:05:00-sun:09:00"
}

variable "notification_topic_arn" {
  description = "The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications will be sent."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
