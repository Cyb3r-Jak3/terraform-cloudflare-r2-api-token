# Terraform Cloudflare R2 API Token

Terraform module to create a Cloudflare API token that have bucket scope permissions.
The API token needed by the Cloudflare provider needs to have `User -> API Tokens -> Edit token` permissions. You can use [this quick link](https://dash.cloudflare.com/profile/api-tokens?permissionGroupKeys=%5B%7B%22key%22%3A%22api_tokens%22%2C%22type%22%3A%22edit%22%7D%5D&name=R2+API+Token+Module&accountId=*&zoneId=all) to create the token with the correct permissions.

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

### Cloudflare provider version support

6.0 and above uses version 5.13 or above of the Cloudflare provider.
5.0 and above uses version 5.0 of the Cloudflare provider.  
4.1.1 and below uses version 4 of the Cloudflare provider.

I will continue to support the 4.1.1 version to the best of my ability, but I will not be adding new features to it. I will only add new features to the 5.0 version of the provider.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 5.13, <6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | >= 5.13, <6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_api_token.token](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token_permission_groups_list.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/api_token_permission_groups_list) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare Account ID | `string` | n/a | yes |
| <a name="input_bucket_read"></a> [bucket\_read](#input\_bucket\_read) | If true, grant read access to the bucket(s) | `bool` | `true` | no |
| <a name="input_bucket_write"></a> [bucket\_write](#input\_bucket\_write) | If true, grant write access to the bucket(s) | `bool` | `true` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | List of R2 buckets to grant access to. If empty, all buckets will be granted access. | `list(string)` | `[]` | no |
| <a name="input_condition_ip_in"></a> [condition\_ip\_in](#input\_condition\_ip\_in) | List of IP addresses or CIDR notation where the token may be used from. If not specified, the token will be valid for all IP addresses. | `list(string)` | `[]` | no |
| <a name="input_condition_ip_not_in"></a> [condition\_ip\_not\_in](#input\_condition\_ip\_not\_in) | List of IP addresses or CIDR notation where the token should not be used from. | `list(string)` | `[]` | no |
| <a name="input_expires_on"></a> [expires\_on](#input\_expires\_on) | The expiration time on or after which the token MUST NOT be accepted for processing. If not specified, the token will not expire. | `string` | `""` | no |
| <a name="input_jurisdiction"></a> [jurisdiction](#input\_jurisdiction) | Jurisdiction of R2 buckets | `string` | `"default"` | no |
| <a name="input_not_before"></a> [not\_before](#input\_not\_before) | The time before which the token MUST NOT be accepted for processing. If not specified, the token will be valid immediately. | `string` | `""` | no |
| <a name="input_status"></a> [status](#input\_status) | Status of the API token. Can be 'active' or 'disabled'. Defaults to 'active'. | `string` | `"active"` | no |
| <a name="input_token_name"></a> [token\_name](#input\_token\_name) | Name of the API token.<br/>If none given then the format is: `R2-<comma separated names>-<Read if 'bucket-read'>-<Write if 'bucket-write'>` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | API Token ID.<br/>Used as the Access Key ID |
| <a name="output_name"></a> [name](#output\_name) | Name of the API Token |
| <a name="output_secret"></a> [secret](#output\_secret) | Secret Access Key |
| <a name="output_value"></a> [value](#output\_value) | API Token Value |
<!-- END_TF_DOCS -->