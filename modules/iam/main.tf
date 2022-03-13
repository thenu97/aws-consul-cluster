resource "aws_iam_instance_profile" "snowplow_instance_profile" {
  name_prefix = "snowplow_consul_ip"
  role        = aws_iam_role.instance_role.name
}

resource "aws_iam_role" "instance_role" {
  name_prefix        = "snowploy_consul_ir"
  assume_role_policy = data.aws_iam_policy_document.snowplow_instance_role.json
}

data "aws_iam_policy_document" "snowplow_instance_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "cluster_discovery" {
  name   = "snowplow_consul_cluster_discovery"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.cluster_discovery.json
}

data "aws_iam_policy_document" "cluster_discovery" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "autoscaling:CompleteLifecycleAction",
      "ec2:DescribeTags"
    ]
    resources = ["*"]
  }
}
