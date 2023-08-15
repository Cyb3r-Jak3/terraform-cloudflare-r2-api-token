output "id" {
  value       = cloudflare_api_token.token.id
  description = "API Token ID. Used as the Acccess Key ID"
}
output "secret" {
  value       = sha256(cloudflare_api_token.token.value)
  sensitive   = true
  description = "Secret Access Key"
}
