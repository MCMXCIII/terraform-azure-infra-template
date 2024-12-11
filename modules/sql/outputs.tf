output "sql_server_fqdn" {
  value = azurerm_postgresql_server.main.fqdn
}
output "database_name" {
  value = azurerm_postgresql_database.main.name
}

