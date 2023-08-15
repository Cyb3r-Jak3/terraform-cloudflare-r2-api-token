terraform {
  required_version = ">= 1.2.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.7.0"
    }
  }
}

module "api-permissions" {
  source  = "Cyb3r-Jak3/api-permissions/cloudflare"
  version = "1.1.0"
}


resource "cloudflare_api_token" "token" {
  name = var.token_name != "" ? var.token_name : "R2-${join(",", var.buckets)}-${var.bucket_read ? "Read" : ""}-${var.bucket_write ? "Write" : ""}"
  policy {
    permission_groups = compact([
      var.bucket_read ? module.api-permissions.r2["Workers R2 Storage Bucket Item Read"] : null,
      var.bucket_write ? module.api-permissions.r2["Workers R2 Storage Bucket Item Write"] : null,
    ])
    resources = { for bucket in var.buckets : "com.cloudflare.edge.r2.bucket.${var.account_id}_default_${bucket}" => "*" }
  }
  not_before = var.not_before != "" ? var.not_before : timestamp()
  expires_on = var.expires_on != "" ? var.expires_on : null
  condition {
    request_ip {
      in     = var.condition_ip_in
      not_in = var.condition_ip_not_in
    }
  }
}