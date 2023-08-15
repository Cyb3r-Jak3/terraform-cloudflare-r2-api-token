variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "token_name" {
    description = "Name of the token"
    type        = string
}

variable "buckets" {
  description = "List of R2 buckets to grant access to"
  type        = list(string)
}

variable "bucket_read" {
  description = "If true, grant read access to the bucket(s)"
  type        = bool
  default = true
}

variable "bucket_write" {
  description = "If true, grant write access to the bucket(s)"
  type        = bool
  default = true
}

variable "not_before" {
  description = "The time before which the token MUST NOT be accepted for processing. If not specified, the token will be valid immediately."
  type        = string
  default = ""
}

variable "expires_on" {
  description = "The expiration time on or after which the token MUST NOT be accepted for processing."
  type        = string
default = ""
}

variable "condition_ip_in" {
  description = "List of IP addresses or CIDR notation where the token may be used from. If not specified, the token will be valid for all IP addresses."
  type        = list(string)
  default = []
}

variable "condition_not_ip_in" {
  description = "List of IP addresses or CIDR notation where the token should not be used from."
  type        = list(string)
  default = [  ]
}