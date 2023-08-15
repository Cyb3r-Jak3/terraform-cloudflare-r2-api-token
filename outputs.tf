output "id" {
  value       = cloudflare_api_token.token.id
  description = "API Token ID.\nUsed as the Acccess Key ID"
}

output "value" {
  value       = cloudflare_api_token.token.value
  sensitive   = true
  description = "API Token Value"
}

output "secret" {
  value       = sha256(cloudflare_api_token.token.value)
  sensitive   = true
  description = "Secret Access Key"
}

output "name" {
  value       = cloudflare_api_token.token.name
  description = "Name of the API Token"
}