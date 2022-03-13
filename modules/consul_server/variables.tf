variable "vpc_id" {
}

variable "ami_id" {
}

variable "instance_type" {
  
}

variable "consul_version" {
  
}

variable "servers_size" {
    type = number
    default = 3
}


variable "security_group_id" {
}

variable "consul_cluster_version" {
  default = 0.1
}

variable "aws_iam_instance_profile" {
    description = "instance profile"
}