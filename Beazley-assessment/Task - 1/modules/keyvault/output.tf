output "kv_name" {
  value       = azurerm_key_vault.kv.name
  description = "Key Vault name"
}

output "kv_id" {
  value       = azurerm_key_vault.kv.id
  description = "Key Vault ID"
}

output "kv_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "Key Vault URI"
}
