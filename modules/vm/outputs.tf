output "vm_private_ip" {
  value = azurerm_linux_virtual_machine.main.private_ip_address
}
output "vm_public_ip" {
  value = azurerm_linux_virtual_machine.main.public_ip_address
}

