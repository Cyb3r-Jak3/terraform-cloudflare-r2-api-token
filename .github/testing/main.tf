terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "cloudflare" {
}

variable "account_id" {
  type = string
}

resource "random_string" "bucket1_name" {
  length  = 32
  special = false
  numeric = true
  upper = false
}

resource "random_string" "bucket2_name" {
  length  = 32
  special = false
  numeric = true
  upper = false
}

resource "cloudflare_r2_bucket" "test1" {
  account_id = var.account_id
  name       = random_string.bucket1_name.result
}

resource "cloudflare_r2_bucket" "test2" {
  account_id = var.account_id
  name       = random_string.bucket2_name.result
}

module "r2-api-token" {
  source       = "../.."
  account_id   = var.account_id
  buckets      = [cloudflare_r2_bucket.test1.name, cloudflare_r2_bucket.test2.name]
  bucket_write = false
  expires_on = timeadd(timestamp(), "10m")
}

module "r2-api-token_custom_name" {
  source       = "../.."
  account_id   = var.account_id
  token_name = "Github Action R2 Module"
  buckets      = [cloudflare_r2_bucket.test1.name, cloudflare_r2_bucket.test2.name]
  bucket_write = false
  expires_on = timeadd(timestamp(), "10m")
}

module "r2-api-token_wildcard" {
  source       = "../.."
  account_id   = var.account_id
  bucket_write = false
  expires_on = timeadd(timestamp(), "10m")
}



module "r2-api-token_eu" {
  source       = "../.."
  account_id   = var.account_id
  bucket_write = false
  expires_on = timeadd(timestamp(), "10m")
  jurisdiction = "eu"
}
