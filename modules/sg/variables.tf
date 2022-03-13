variable "ingress_ports_tcp" {
  type = list(number)
  description = "list of ingress tcp ports"
  default = [22,8500,8600,8300]
}

variable "egress_ports_tcp" {
  type = list(number)
  description = "list of egress tcp ports"
  default = [443,80] 
}

variable "vpc_id" {
  description = "vpc id"
}