locals {
  opensearch_widgets = concat([], [
    for cluster in var.opensearch_clusters :
    [
      {
        type = "metric"

        properties = {
          title   = "[ES] Status (cluster: ${coalesce(cluster.label, cluster.name)})"
          view    = "timeSeries"
          region  = coalesce(cluster.region, var.default_region)
          stacked = true

          yAxis = {
            left = {
              min = 0
              max = 1
            }
          }

          metrics = [
            [
              "AWS/ES",
              "ClusterStatus.red",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { color = "#d62728" }
            ],
            [
              "AWS/ES",
              "ClusterStatus.yellow",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { color = "#ffbb78" }
            ],
            [
              "AWS/ES",
              "ClusterStatus.green",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { color = "#2ca02c" }
            ],
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ES] Latency (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/ES",
              "ReadLatency",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
            ],
            [
              "AWS/ES",
              "WriteLatency",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
            ],
            [
              "AWS/ES",
              "SearchLatency",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
            ],
            [
              "AWS/ES",
              "IndexingLatency",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ES] IOPS & Throughput (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }

            right = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/ES",
              "ReadIOPS",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { yAxis = "left" }
            ],
            [
              "AWS/ES",
              "WriteIOPS",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { yAxis = "left" }
            ],
            [
              "AWS/ES",
              "ReadThroughput",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { yAxis = "right" }
            ],
            [
              "AWS/ES",
              "WriteThroughput",
              "DomainName",
              cluster.name,
              "ClientId",
              data.aws_caller_identity.this.account_id,
              { yAxis = "right" }
            ]
          ]
        }
      }
    ]
  ]...)
}
