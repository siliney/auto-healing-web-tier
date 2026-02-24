resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.name_prefix}-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_sku
  instances           = var.instance_count
  admin_username      = var.admin_username
  health_probe_id = var.health_probe_id

  upgrade_mode = "Automatic"

  # Self-healing (automatic instance repairs) depends on health monitoring.
  # Here we use the Load Balancer probe + automatic repairs.
  automatic_instance_repair {
    enabled      = true
    grace_period = "PT10M"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "ipconfig"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = [var.backend_pool_id]
    }
  }

  # cloud-init
  custom_data = base64encode(var.cloud_init)

  tags = var.tags
}
