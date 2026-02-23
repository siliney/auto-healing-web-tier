resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  name_prefix         = local.name_prefix
  tags                = local.tags
}

module "lb" {
  source              = "./modules/lb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  name_prefix         = local.name_prefix
  subnet_id           = module.network.subnet_id
  tags                = local.tags
}

module "vmss" {
  source              = "./modules/vmss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  name_prefix         = local.name_prefix

  subnet_id           = module.network.subnet_id
  backend_pool_id     = module.lb.backend_pool_id

  instance_count      = var.instance_count
  vm_sku              = var.vm_sku
  admin_username      = var.admin_username
  ssh_public_key      = file(var.ssh_public_key_path)

  cloud_init = var.use_docker
    ? templatefile("${path.module}/cloud-init/docker.yaml", { image = var.container_image })
    : file("${path.module}/cloud-init/nginx.yaml")

  tags = local.tags
}
