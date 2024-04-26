output "arn" {
  description = "The ARN of the DAX. Will be of format arn:aws:s3:::bucketname."
  value       = try(resource.aws_dax_cluster.this.arn, "")
}
