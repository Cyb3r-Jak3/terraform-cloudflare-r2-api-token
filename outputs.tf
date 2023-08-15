output "tf_test_r2_token_id" {
  value       = cloudflare_api_token.token.id
  description = "Access Key ID"
}
output "tf_test_r2_token_value" {
  value       = sha256(cloudflare_api_token.token.value)
  sensitive   = true
  description = "Secret Access Key"
}
