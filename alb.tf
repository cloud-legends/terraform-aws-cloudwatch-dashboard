locals {
  alb_widgets = concat([], [
    for alb in var.application_load_balancers :
    [
      {
        type = "metric"

        properties = {
          title  = "[ALB] Request counts (alb: ${coalesce(alb.label, alb.name)})"
          view   = "timeSeries"
          region = coalesce(alb.region, var.default_region)
          stat   = "Sum"

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            for target_group in alb.target_groups :
            [
              "AWS/ApplicationELB",
              "RequestCountPerTarget",
              "LoadBalancer",
              alb.name,
              "TargetGroup",
              target_group.name,
              { label = coalesce(target_group.label, target_group.name) }
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ALB] 5XX Error Rates (alb: ${coalesce(alb.label, alb.name)})"
          view   = "timeSeries"
          region = coalesce(alb.region, var.default_region)

          yAxis = {
            left = {
              label     = "Percent"
              showUnits = false
              min       = 0
            }
          }

          metrics = concat([], [
            for index, target_group in alb.target_groups :
            [
              [
                "AWS/ApplicationELB",
                "HTTPCode_Target_5XX_Count",
                "LoadBalancer",
                alb.name,
                "TargetGroup",
                target_group.name,
                { id = "error${index}", visible = false }
              ],
              [
                "AWS/ApplicationELB",
                "RequestCountPerTarget",
                "LoadBalancer",
                alb.name,
                "TargetGroup",
                target_group.name,
                { id = "total${index}", visible = false }
              ],
              [
                {
                  label      = coalesce(target_group.label, target_group.name)
                  expression = "IF(total${index} == 0, 0, error${index} / total${index})"
                }
              ]
            ]
          ]...)
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ALB] Response time (alb: ${coalesce(alb.label, alb.name)})"
          view   = "timeSeries"
          region = coalesce(alb.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            for index, target_group in alb.target_groups :
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              alb.name,
              "TargetGroup",
              target_group.name,
              { label = coalesce(target_group.label, target_group.name) }
            ]
          ]
        }
      }
    ]
  ]...)
}
