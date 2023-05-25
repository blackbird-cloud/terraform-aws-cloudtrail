output "cloudtrail" {
  value       = aws_cloudtrail.default
  description = "The CloudTrail resource."
}

output "bucket" {
  value       = module.bucket
  description = "The S3 Bucket that stores the CloudTrail."
}

output "kms_key" {
  value       = module.kms_key
  description = "The KMS key used to encrypt the CloudTrail."
}
