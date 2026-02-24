resource "azurerm_monitor_autoscale_setting" "vmss" {
  name                = "${local.name_prefix}-autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  target_resource_id  = module.vmss.vmss_id
  enabled             = true

  profile {
    name = "default"

    capacity {
      minimum = "2"
      default = "2"
      maximum = "2"
    }

    # Optional rules (example): scale out if CPU > 70% for 10 mins
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = module.vmss.vmss_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # Optional rules (example): scale in if CPU < 30% for 10 mins
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = module.vmss.vmss_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }

  tags = local.tags
}
