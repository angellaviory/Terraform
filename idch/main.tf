#Hashicorp Registery for IDCloudHost
terraform {
  required_providers {
    idcloudhost = {
      source = "bapung/idcloudhost"
      version = "0.1.2"
    }
  }
}

# Token from Access section in IDCloudHost
provider "idcloudhost" {
    auth_token = "Token"
}

#Server
resource "idcloudhost_vm" "vm_name" {
    name = "vm_name"
    os_name = "os_name"
    os_version= "version_os"
    disks = "xxx"
    vcpu = "xxx"
    memory = "xxx"
    username = "username"
    initial_password = "password"
    billing_account_id = "copy_from_billing_section_account_id"
    backup = false
}

#Floating IP
resource "idcloudhost_floating_ip" "ip_name" {
    name = "ip_name"
    billing_account_id = "copy_from_billing_section_account_id"
    assigned_to = idcloudhost_vm."vm_name".id
}

