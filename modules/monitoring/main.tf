resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = [

      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 2

        properties = {
          markdown = "# Dev Application Platform\nTerraform-managed monitoring dashboard"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 2
        width  = 12
        height = 6

        properties = {
          title  = "ALB Request Count"
          region = var.region
          view   = "timeSeries"
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              var.load_balancer_arn_suffix
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 2
        width  = 12
        height = 6

        properties = {
          title  = "Target Response Time"
          region = var.region
          view   = "timeSeries"
          stat   = "Average"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "LoadBalancer",
              var.load_balancer_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 8
        width  = 12
        height = 6

        properties = {
          title  = "Target Health"
          region = var.region
          view   = "timeSeries"
          period = 60

          metrics = [
            [
              "AWS/ApplicationELB",
              "HealthyHostCount",
              "LoadBalancer",
              var.load_balancer_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix,
              {
                stat  = "Average"
                label = "Healthy Targets"
              }
            ],

            [
              "AWS/ApplicationELB",
              "UnHealthyHostCount",
              "LoadBalancer",
              var.load_balancer_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix,
              {
                stat  = "Average"
                label = "Unhealthy Targets"
              }
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 8
        width  = 12
        height = 6

        properties = {
          title  = "HTTP 5XX Errors"
          region = var.region
          view   = "timeSeries"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_ELB_5XX_Count",
              "LoadBalancer",
              var.load_balancer_arn_suffix,
              {
                stat  = "Sum"
                label = "ALB 5XX"
              }
            ],

            [
              "AWS/ApplicationELB",
              "HTTPCode_Target_5XX_Count",
              "LoadBalancer",
              var.load_balancer_arn_suffix,
              "TargetGroup",
              var.target_group_arn_suffix,
              {
                stat  = "Sum"
                label = "Target 5XX"
              }
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 14
        width  = 24
        height = 6

        properties = {
          title  = "Auto Scaling Group Capacity"
          region = var.region
          view   = "timeSeries"
          period = 60

          metrics = [
            [
              "AWS/AutoScaling",
              "GroupDesiredCapacity",
              "AutoScalingGroupName",
              var.autoscaling_group_name,
              {
                stat  = "Average"
                label = "Desired"
              }
            ],

            [
              "AWS/AutoScaling",
              "GroupInServiceInstances",
              "AutoScalingGroupName",
              var.autoscaling_group_name,
              {
                stat  = "Average"
                label = "In Service"
              }
            ],

            [
              "AWS/AutoScaling",
              "GroupPendingInstances",
              "AutoScalingGroupName",
              var.autoscaling_group_name,
              {
                stat  = "Average"
                label = "Pending"
              }
            ],

            [
              "AWS/AutoScaling",
              "GroupTerminatingInstances",
              "AutoScalingGroupName",
              var.autoscaling_group_name,
              {
                stat  = "Average"
                label = "Terminating"
              }
            ]
          ]
        }
      }
    ]
  })
}