locals {
  default_region = coalesce(var.default_region, data.aws_region.this.name)
}
