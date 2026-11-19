variable "resource_group_name" {
  description = "Назва групи ресурсів в Azure"
  type        = string
  default     = "rg-shopping-list-lab4"
}

variable "location" {
  description = "Регіон розгортання інфраструктури"
  type        = string
  default     = "Sweden Central"
}

variable "vm_size" {
  description = "Розмір віртуальної машини (Standard_B1s економить баланс)"
  type        = string
  default     = "Standard_B2ts_v2"
}

variable "admin_username" {
  description = "Ім'я адміністратора для підключення по SSH"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Шлях до публічного SSH-ключа"
  type        = string
  default     = "~/.ssh/azure_lab4_key.pub"
}