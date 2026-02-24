output "public_url" {
  value = "http://${module.lb.public_ip}"
}

output "public_ip" {
  value = module.lb.public_ip
}

output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.id
}
