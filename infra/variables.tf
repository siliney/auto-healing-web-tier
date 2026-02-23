variable "project" { type = string, default = "autoheal-web" }
variable "env"     { type = string, default = "dev" }
variable "owner"   { type = string, default = "candidate" }

variable "location" {
  type    = string
  default = "australiaeast"
}

variable "vm_sku" {
  type    = string
  default = "Standard_B1ls"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

# SSH public key path on your machine
variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

# Optional: switch to docker cloud-init (bonus)
variable "use_docker" {
  type    = bool
  default = false
}

# Optional: container image to run when use_docker=true (bonus)
variable "container_image" {
  type    = string
  default = ""
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}
