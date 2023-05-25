data "aws_caller_identity" "default" {}

module "kms_key" {
  source  = "blackbird-cloud/kms-key/aws"
  version = "~> 0"

  name   = var.name
  policy = <<EOF
  {
    "Id": "key-policy-1",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.default.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": ${jsonencode(var.administrator_arns)}
            },
            "Action": [
                "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource",
                "kms:ScheduleKeyDeletion",
                "kms:CancelKeyDeletion"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow read access for Key users",
            "Effect": "Allow", 
            "Principal": {
                "AWS": ${jsonencode(var.viewers_arns)}
            }, 
            "Action": [ 
                "kms:Decrypt",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
        {
            "Sid": "AWSCloudTrail", 
            "Effect": "Allow", 
            "Principal": {
                "Service": [ "cloudtrail.amazonaws.com" ] 
            }, 
            "Action": [ 
                "kms:Encrypt",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  tags   = var.tags
}

module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3"

  bucket_prefix = var.name

  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_policy     = true
  block_public_acls       = true

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = module.kms_key.kms.arn
      }
    }
  }
  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      id      = "lifecycle-rule-1"
      enabled = true

      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      noncurrent_version_expiration = {
        days = 90
      }
    }
  ]
  tags = var.tags
}

module "bucket_policy" {
  source  = "blackbird-cloud/s3-bucket-policy/aws"
  version = "~> 0"

  s3_bucket_id = module.bucket.s3_bucket_id

  policy = <<EOF
module "bucket_policy" {
  source  = "blackbird-cloud/s3-bucket-policy/aws"
  version = "~> 0"

  s3_bucket_id = module.bucket.s3_bucket_id
  policy       = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "${module.bucket.s3_bucket_arn}"
    },
    {
      "Sid": "AWSCloudTrailWrite",
      "Effect": "Allow",
      "Principal": {
          "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "${module.bucket.s3_bucket_arn}/AWSLogs/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    }
  ]
}
EOF
}

resource "aws_cloudtrail" "default" {
  name           = var.name
  s3_bucket_name = module.bucket.s3_bucket_id

  is_multi_region_trail = var.is_multi_region_trail
  is_organization_trail = var.is_organization_trail

  cloud_watch_logs_group_arn    = var.cloud_watch_logs_group_arn
  cloud_watch_logs_role_arn     = var.cloud_watch_logs_role_arn
  enable_log_file_validation    = var.enable_log_file_validation
  include_global_service_events = var.include_global_service_events
  tags                          = var.tags
}
