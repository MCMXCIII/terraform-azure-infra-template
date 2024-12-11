# Define the Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "WDLA-dev-rg"
  location = "East US"
}

# VNet Module
module "vnet" {
  source               = "../../modules/vnet"
  vnet_name            = "dev-vnet"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  address_space        = ["10.0.0.0/16"]
  private_subnet_name  = "dev-private-subnet"
  private_subnet_cidr  = ["10.0.1.0/24"]
  public_subnet_name   = "dev-public-subnet"
  public_subnet_cidr   = ["10.0.2.0/24"]
}

# Create a Network Interface for the VM
resource "azurerm_network_interface" "main" {
  name                = "dev-vm-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.private_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux VM Module
module "vm" {
  source              = "../../modules/vm"
  vm_name             = "dev-linux-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  network_interface_id = azurerm_network_interface.main.id
  admin_username      = "wdla-admin"
  ssh_public_key      = file("~/.ssh/id_rsa.pub")
  vm_size             = "Standard_B2s"
}

# SQL Database Module
module "sql" {
  source              = "../../modules/sql"
  sql_server_name     = "dev-sql-server"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "B_Gen5_1"
  admin_username      = "adminuser"
  admin_password      = "SecurePassword123!" # Replace with a secure password
  database_name       = "wdla_database"
}

# Outputs for verification
output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vm_private_ip" {
  value = azurerm_network_interface.main.private_ip_address
}

output "sql_server_fqdn" {
  value = module.sql.sql_server_fqdn
}

