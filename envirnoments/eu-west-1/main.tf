module "consul_server" {
  source                   = "../../modules/consul_server"
  vpc_id                   = module.vpc.vpc_id
  ami_id                   = "ami-0f29c8402f8cce65c"
  consul_version           = "1.11.4"
  instance_type            = var.instance_type_input
  aws_iam_instance_profile = module.iam.iam_profile_name
  security_group_id        = module.sg.security_group_id
}

module "consul_client" {
  source                   = "../../modules/consul_client"
  instance_type            = var.instance_type_input
  vpc_id                   = module.vpc.vpc_id
  consul_version           = "1.11.4"
  ami_id                   = "ami-0f29c8402f8cce65c"
  aws_iam_instance_profile = module.iam.iam_profile_name
  security_group_id        = module.sg.security_group_id

}

module "iam" {
  source = "../../modules/iam"
}

module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = "12.0.0.0/16"
}

module "sg" {
  source = "../../modules/sg"
  vpc_id = module.vpc.vpc_id
}
