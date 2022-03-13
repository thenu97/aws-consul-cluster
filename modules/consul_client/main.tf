data "aws_region" "current" {}

data "aws_vpc" "snowplow_vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.snowplow_vpc.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_autoscaling_group" "snowplow_asg_client" {
  name                      = aws_launch_configuration.snowplow_alc_client.name
  launch_configuration      = aws_launch_configuration.snowplow_alc_client.name
  availability_zones        = data.aws_availability_zones.available.zone_ids
  min_size                  = var.cluster_size
  max_size                  = var.cluster_size
  desired_capacity          = var.cluster_size
  wait_for_capacity_timeout = "480s"
  health_check_grace_period = 15
  health_check_type         = "EC2"
  vpc_zone_identifier       = data.aws_subnet_ids.default.ids

  tag {
      key                 = "Cluster-Name"
      value               = var.cluster_name
      propagate_at_launch = true
    }

  #so when terraform is changing a resource, we don't lose our current one to minimise downtime
  #   lifecycle {
  #     create_before_destroy = true
  #   }
}


resource "aws_launch_configuration" "snowplow_alc_client" {
  name            = "snowplow_alc_client"
  instance_type   = var.instance_type
  key_name        = "snowplow"
  image_id = var.ami_id
  spot_price      = null
  security_groups = [var.security_group_id]
  user_data = templatefile("../../scripts/config_client.sh.template",
    {
      consul_version         = var.consul_version,
      datacenter             = data.aws_region.current.name,
  })
  associate_public_ip_address = false
  iam_instance_profile        = var.aws_iam_instance_profile
  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  #   lifecycle {
  #     create_before_destroy = true
  #   }
}
