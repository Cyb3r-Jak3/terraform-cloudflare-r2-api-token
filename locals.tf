locals {
  not_before = var.not_before != "" ? var.not_before : formatdate(timestamp(), "YYYY-MM-DDThh:mm:ssZ")
}