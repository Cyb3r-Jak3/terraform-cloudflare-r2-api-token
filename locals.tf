locals {
  not_before = var.not_before != "" ? var.not_before : formatdate(timestamp(), "YYYY-MM-DDThh:mm:ssZ")
  token_name = var.token_name != "" ? var.token_name : "R2-${join(",", var.buckets)}-${var.bucket_read ? "Read" : ""}-${var.bucket_write ? "Write" : ""}"
}