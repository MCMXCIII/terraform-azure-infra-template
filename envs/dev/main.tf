module "vnet" {
  source               = "../../modules/vnet"
  vnet_name            = "dev-vnet"
  location             = "East US"
  resource_group_name  = "WDLA-dev-rg"
  address_space        = ["10.0.0.0/16"]
  private_subnet_name  = "dev-private-subnet"
  private_subnet_cidr  = ["10.0.1.0/24"]
  public_subnet_name   = "dev-public-subnet"
  public_subnet_cidr   = ["10.0.2.0/24"]
}

module "vm" {
  source              = "../../modules/vm"
  vm_name             = "dev-linux-vm"
  location            = "East US"
  resource_group_name = "WDLA-dev-rg"
  network_interface_id = module.vnet.private_subnet_id
  admin_username      = "wdla-admin"
  ssh_public_key      = file("~/.ssh/id_rsa.pub")
}

module "sql" {
  source              = "../../modules/sql"
  sql_server_name     = "dev-sql-server"
  location            = "East US"
  resource_group_name = "WDLA-dev-rg"
  admin_username      = "adminuser"
  admin_password      = "SecurePassword123!"
  database_name       = "wdla_database"
}

