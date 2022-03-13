variable "profile" {
  description = "The profile configured in awscli"
  default     = "root"
}
variable "account_id" {
  description = "Your AWS Account Id e.g 042123456789"
}
variable "environment" {
  description = "Your Environment to deploy in e.g. test, production etc"
  default     = "test"
}
variable "region" {
  description = "The AWS Region to deploy the infrastructure in e.g. eu-west-1"
  default     = "eu-west-1"
}
variable "instance_type_input" {
  description = "The instance type for the EC2 Instance"
  default     = "t2.micro"
}
