# terraform-cloudflare-r2-api-token

Terraform module to create a Cloudflare API token that have bucket scope tokens.

Example:
```hcl
module "r2-api-token" {
  source  = "Cyb3r-Jak3/r2-api-token/cloudflare"
  version = "<version>"
  account_id = "<account>"
  buckets = ["bucket-1", "bucket-2"]
  write = false
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 4.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | >= 4.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api-permissions"></a> [api-permissions](#module\_api-permissions) | Cyb3r-Jak3/api-permissions/cloudflare | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [cloudflare_api_token.token](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare Account ID | `string` | n/a | yes |
| <a name="input_bucket_read"></a> [bucket\_read](#input\_bucket\_read) | If true, grant read access to the bucket(s) | `bool` | `true` | no |
| <a name="input_bucket_write"></a> [bucket\_write](#input\_bucket\_write) | If true, grant write access to the bucket(s) | `bool` | `true` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | List of R2 buckets to grant access to | `list(string)` | n/a | yes |
| <a name="input_condition_ip_in"></a> [condition\_ip\_in](#input\_condition\_ip\_in) | List of IP addresses or CIDR notation where the token may be used from. If not specified, the token will be valid for all IP addresses. | `list(string)` | `[]` | no |
| <a name="input_condition_not_ip_in"></a> [condition\_not\_ip\_in](#input\_condition\_not\_ip\_in) | List of IP addresses or CIDR notation where the token should not be used from. | `list(string)` | `[]` | no |
| <a name="input_expires_on"></a> [expires\_on](#input\_expires\_on) | The expiration time on or after which the token MUST NOT be accepted for processing. | `string` | `""` | no |
| <a name="input_not_before"></a> [not\_before](#input\_not\_before) | The time before which the token MUST NOT be accepted for processing. If not specified, the token will be valid immediately. | `string` | `""` | no |
| <a name="input_token_name"></a> [token\_name](#input\_token\_name) | Name of the token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tf_test_r2_token_id"></a> [tf\_test\_r2\_token\_id](#output\_tf\_test\_r2\_token\_id) | Access Key ID |
| <a name="output_tf_test_r2_token_value"></a> [tf\_test\_r2\_token\_value](#output\_tf\_test\_r2\_token\_value) | Secret Access Key |
<!-- END_TF_DOCS -->