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

resource "random_string" "bucket_name" {
  length  = 32
  special = false
  numeric = false

}

resource "cloudflare_r2_bucket" "test" {
  account_id = var.account_id
  name       = random_string.bucket_name.result
}

module "r2-api-token" {
  source       = "../.."
  account_id   = var.account_id
  buckets      = [cloudflare_r2_bucket.test_token_bucket.name]
  bucket_write = false
}
