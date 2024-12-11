variable "vm_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "vm_size" {
  default = "Standard_B2s"
}
variable "network_interface_id" {}
variable "admin_username" {}
variable "ssh_public_key" {}

