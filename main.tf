terraform {
  required_version = ">= 1.2.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.7.0"
    }
  }
}

data "cloudflare_api_token_permission_groups" "this" {}

locals {
  resources = var.allow_all_buckets ? {"com.cloudflare.edge.r2.bucket.${var.account_id}*" => "*"} : { for bucket in var.buckets : "com.cloudflare.edge.r2.bucket.${var.account_id}_default_${bucket}" => "*" }
}

resource "cloudflare_api_token" "token" {
  name = var.token_name != "" ? var.token_name : "R2-${join(",", var.buckets)}-${var.bucket_read ? "Read" : ""}-${var.bucket_write ? "Write" : ""}"
  policy {
    permission_groups = compact([
      var.bucket_read ? data.cloudflare_api_token_permission_groups.this.r2["Workers R2 Storage Bucket Item Read"] : null,
      var.bucket_write ? data.cloudflare_api_token_permission_groups.this.r2["Workers R2 Storage Bucket Item Write"] : null,
    ])
    resources = local.resources
  }
  not_before = var.not_before != "" ? var.not_before : null
  expires_on = var.expires_on != "" ? var.expires_on : null
  condition {
    request_ip {
      in     = var.condition_ip_in
      not_in = var.condition_ip_not_in
    }
  }
}