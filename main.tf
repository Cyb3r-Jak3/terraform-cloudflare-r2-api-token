terraform {
  required_version = ">= 1.2.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5, <6"
    }
  }
}

data "cloudflare_api_token_permission_groups_list" "this" {
}

locals {
  resources          = length(var.buckets) > 0 ? { for bucket in var.buckets : "com.cloudflare.edge.r2.bucket.${var.account_id}_${var.jurisdiction}_${bucket}" => "*" } : { "com.cloudflare.edge.r2.bucket.*" = "*" }
  token_bucket_names = length(var.buckets) > 0 ? join(",", var.buckets) : "All-Buckets"
  r2_api_permissions = { for x in data.cloudflare_api_token_permission_groups_list.this.result : x.name => x.id if contains(["Workers R2 Storage Bucket Item Read", "Workers R2 Storage Bucket Item Write"], x.name) }
  permission_id_list = compact([
    var.bucket_read ? local.r2_api_permissions["Workers R2 Storage Bucket Item Read"] : null,
    var.bucket_write ? local.r2_api_permissions["Workers R2 Storage Bucket Item Write"] : null,
  ])
}

resource "cloudflare_api_token" "token" {
  name = var.token_name != "" ? var.token_name : "R2-${local.token_bucket_names}-${var.bucket_read ? "Read" : ""}-${var.bucket_write ? "Write" : ""}"
  policies = [{
    effect            = "allow"
    resources         = local.resources
    permission_groups = [for x in local.permission_id_list : { id = x }]
  }]
  not_before = var.not_before != "" ? var.not_before : null
  expires_on = var.expires_on != "" ? var.expires_on : null
  condition = {
    request_ip = {
      in     = var.condition_ip_in
      not_in = var.condition_ip_not_in
    }
  }
  status = var.status
}