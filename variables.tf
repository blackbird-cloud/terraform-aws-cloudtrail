variable "name" {
  type        = string
  description = "Name used for all resources created."
}

variable "administrator_arns" {
  type        = list(string)
  description = "List of AWS principals that will receive Administrative permissions on the resources created."
  default     = []
}

variable "viewers_arns" {
  type        = list(string)
  description = "(Optional) List of AWS principals that will receive viewing permissions on the Cloudtrail data."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Map of tags to assign to the trail. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "is_multi_region_trail" {
  type        = bool
  default     = true
  description = "(Optional) Whether the trail is created in the current region or in all regions. Defaults to `false`."
}

variable "is_organization_trail" {
  type        = bool
  default     = true
  description = "(Optional) Whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to `false`."
}

variable "cloud_watch_logs_group_arn" {
  type        = string
  description = "(Optional) Log group name using an ARN that represents the log group to which CloudTrail logs will be delivered. Note that CloudTrail requires the Log Stream wildcard."
  default     = ""
}

variable "cloud_watch_logs_role_arn" {
  type        = string
  default     = ""
  description = "(Optional) Role for the CloudWatch Logs endpoint to assume to write to a user’s log group."
}

variable "enable_log_file_validation" {
  type        = bool
  default     = false
  description = "(Optional) Whether log file integrity validation is enabled. Defaults to `false`."
}

variable "include_global_service_events" {
  type        = string
  description = "(Optional) Whether the trail is publishing events from global services such as IAM to the log files. Defaults to `true`."
}

