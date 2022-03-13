data "aws_region" "current" {}

data "aws_vpc" "consul_vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.consul_vpc.id
}

data "aws_availability_zones" "available" {
  state = "available"

}

resource "aws_autoscaling_group" "consul_servers" {
  name                      = aws_launch_configuration.snowplow_consul_servers.name
  launch_configuration      = aws_launch_configuration.snowplow_consul_servers.name
  availability_zones        = data.aws_availability_zones.available.zone_ids
  min_size                  = var.servers_size
  max_size                  = var.servers_size
  desired_capacity          = var.servers_size
  wait_for_capacity_timeout = "480s"
  health_check_grace_period = 15
  health_check_type         = "EC2"
  vpc_zone_identifier       = data.aws_subnet_ids.default.ids
  tag {
    key                 = "Cluster-Name"
    value               = "snowplow"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "snowplow_consul_servers" {
  name            = "snowplow_consul_servers"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = "snowplow"
  security_groups = [var.security_group_id]
  user_data = templatefile("../../scripts/config_server.sh.template",
    {
      consul_version         = var.consul_version,
      datacenter             = data.aws_region.current.name,
      total_nodes            = var.servers_size,
      consul_cluster_version = var.consul_cluster_version,
      bootstrap_expect       = var.servers_size

  })
  associate_public_ip_address = false
  iam_instance_profile        = var.aws_iam_instance_profile
  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  lifecycle {
    create_before_destroy = true
  }
}
