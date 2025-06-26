variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "jurisdiction" {
  description = "Jurisdiction of R2 buckets"
  type        = string
  default     = "default"
}

variable "token_name" {
  description = "Name of the API token.\nIf none given then the fomart is: `R2-<comma separated names>-<Read if 'bucket-read'>-<Write if 'bucket-write'>`"
  type        = string
  default     = ""
}

variable "buckets" {
  description = "List of R2 buckets to grant access to. If empty, all buckets will be granted access."
  type        = list(string)
  default     = []
}

variable "bucket_read" {
  description = "If true, grant read access to the bucket(s)"
  type        = bool
  default     = true
}

variable "bucket_write" {
  description = "If true, grant write access to the bucket(s)"
  type        = bool
  default     = true
}

variable "not_before" {
  description = "The time before which the token MUST NOT be accepted for processing. If not specified, the token will be valid immediately."
  type        = string
  default     = ""
}

variable "expires_on" {
  description = "The expiration time on or after which the token MUST NOT be accepted for processing. If not specified, the token will not expire."
  type        = string
  default     = ""
}

variable "condition_ip_in" {
  description = "List of IP addresses or CIDR notation where the token may be used from. If not specified, the token will be valid for all IP addresses."
  type        = list(string)
  default     = []
}

variable "condition_ip_not_in" {
  description = "List of IP addresses or CIDR notation where the token should not be used from."
  type        = list(string)
  default     = []
}

variable "status" {
  description = "Status of the API token. Can be 'active' or 'disabled'. Defaults to 'active'."
  type        = string
  default     = "active"
  validation {
    condition     = contains(["active", "disabled"], var.status)
    error_message = "Status must be either 'active' or 'disabled'."
  }
}