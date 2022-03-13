output "iam_profile_name" {
    description = "arn of iam profile"
    value = aws_iam_instance_profile.snowplow_instance_profile.name
}