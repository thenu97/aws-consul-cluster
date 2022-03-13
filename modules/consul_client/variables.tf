variable "aws_iam_instance_profile" {
    description = "instance profile"
}

variable "ami_id" {
    description = "ami id"
}

variable "instance_type" {
    description = "instance type"  
}

variable "cluster_size" {
    type = number
    default = 5
    description = "number of ec2s"
}

variable "cluster_name" {
    default = "snowplow"
    description = "name of cluster"
}

variable "consul_version" {
}

variable "vpc_id" {  
}


variable "security_group_id" {
}

variable "consul_cluster_version" {
  default = 0.1
}