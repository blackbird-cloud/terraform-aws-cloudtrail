[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 3 |
| <a name="module_bucket_policy"></a> [bucket\_policy](#module\_bucket\_policy) | blackbird-cloud/s3-bucket-policy/aws | ~> 0 |
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | blackbird-cloud/kms-key/aws | ~> 0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_arns"></a> [administrator\_arns](#input\_administrator\_arns) | List of AWS principals that will receive Administrative permissions on the resources created. | `list(string)` | `[]` | no |
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | (Optional) Log group name using an ARN that represents the log group to which CloudTrail logs will be delivered. Note that CloudTrail requires the Log Stream wildcard. | `string` | `""` | no |
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | (Optional) Role for the CloudWatch Logs endpoint to assume to write to a user’s log group. | `string` | `""` | no |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | (Optional) Whether log file integrity validation is enabled. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_include_global_service_events"></a> [include\_global\_service\_events](#input\_include\_global\_service\_events) | (Optional) Whether the trail is publishing events from global services such as IAM to the log files. Defaults to `true`. | `string` | n/a | yes |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | (Optional) Whether the trail is created in the current region or in all regions. Defaults to `false`. | `bool` | `true` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | (Optional) Whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to `false`. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used for all resources created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Map of tags to assign to the trail. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_viewers_arns"></a> [viewers\_arns](#input\_viewers\_arns) | (Optional) List of AWS principals that will receive viewing permissions on the Cloudtrail data. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The S3 Bucket that stores the CloudTrail. |
| <a name="output_cloudtrail"></a> [cloudtrail](#output\_cloudtrail) | The CloudTrail resource. |
| <a name="output_kms_key"></a> [kms\_key](#output\_kms\_key) | The KMS key used to encrypt the CloudTrail. |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://blackbird.cloud)
