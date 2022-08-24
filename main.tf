locals {
  widgets_per_row = floor(24 / var.widget_width)

  widgets_raw = concat(
    local.cloudfront_widgets,
    local.alb_widgets,
    local.ecs_widgets,
    local.rds_widgets,
    local.elasticache_redis_widgets,
    local.elasticache_memcached_widgets,
    local.opensearch_widgets
  )

  widgets = [
    for index, widget in local.widgets_raw :
    merge(
      widget,
      {
        height = var.widget_height
        width  = var.widget_width
        x      = (index % local.widgets_per_row) * var.widget_width
        y      = floor(index / local.widgets_per_row) * var.widget_height
      }
    )
  ]
}

resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({ widgets = local.widgets })
}
