locals {
  name_prefix = "${var.project}-${var.env}"
  tags = merge(
    {
      Project     = var.project
      Environment = var.env
      ManagedBy   = "Terraform"
      Owner       = var.owner
    },
    var.extra_tags
  )
}
