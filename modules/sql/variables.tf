variable "sql_server_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "sku_name" {
  default = "B_Gen5_1"
}
variable "admin_username" {}
variable "admin_password" {}
variable "database_name" {}

