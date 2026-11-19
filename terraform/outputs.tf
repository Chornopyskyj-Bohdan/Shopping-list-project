output "public_ip_address" {
  description = "Публічна IP-адреса віртуальної машини для Ansible та SSH"
  value       = azurerm_public_ip.main.ip_address
}

output "ssh_connection_command" {
  description = "Готова команда для підключення до сервера по SSH"
  value       = "ssh -i ~/.ssh/azure_lab4_key ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}