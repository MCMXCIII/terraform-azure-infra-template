resource "azurerm_postgresql_server" "main" {
  name                = var.sql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  storage_mb          = 5120
  administrator_login = var.admin_username
  administrator_login_password = var.admin_password
  version             = "11"
}

resource "azurerm_postgresql_database" "main" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.main.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

