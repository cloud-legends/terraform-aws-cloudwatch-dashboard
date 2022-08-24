locals {
  cloudfront_widgets = concat([], [
    for distribution in var.cloudfront_distributions :
    [
      {
        type = "metric"

        properties = {
          title = "[CloudFront] Requests (distribution: ${coalesce(distribution.label, distribution.name)})"

          view   = "timeSeries"
          region = "us-east-1"
          stat   = "Sum"

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/CloudFront",
              "Requests",
              "Region",
              "Global",
              "DistributionId",
              distribution.name
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title = "[CloudFront] Throughput (distribution: ${coalesce(distribution.label, distribution.name)})"

          view   = "timeSeries"
          region = "us-east-1"

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/CloudFront",
              "BytesDownloaded",
              "Region",
              "Global",
              "DistributionId",
              distribution.name
            ],
            [
              "AWS/CloudFront",
              "BytesUploaded",
              "Region",
              "Global",
              "DistributionId",
              distribution.name
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title = "[CloudFront] Error rate (distribution: ${coalesce(distribution.label, distribution.name)})"

          view   = "timeSeries"
          region = "us-east-1"

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/CloudFront",
              "4xxErrorRate",
              "Region",
              "Global",
              "DistributionId",
              distribution.name
            ],
            [
              "AWS/CloudFront",
              "5xxErrorRate",
              "Region",
              "Global",
              "DistributionId",
              distribution.name
            ],
            [
              "AWS/CloudFront",
              "TotalErrorRate",
              "Region",
              "Global",
              "DistributionId",
              distribution.name
            ]
          ]
        }
      }
    ]
  ]...)
}
