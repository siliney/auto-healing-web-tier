variable "resource_group_name" { type = string }
variable "location"            { type = string }
variable "name_prefix"         { type = string }

variable "subnet_id"       { type = string }
variable "backend_pool_id" { type = string }

variable "instance_count"  { type = number }
variable "vm_sku"          { type = string }

variable "admin_username"  { type = string }
variable "ssh_public_key"  { type = string }

# cloud-init content (YAML)
variable "cloud_init" { type = string }

variable "tags" { type = map(string) }
