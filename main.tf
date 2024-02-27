module "network" {
  source = "./modules/network"

  vpc_name           = "microservices"
  cidr_range         = "10.0.0.0/20"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}


module "security" {
  source = "./modules/security "

  vpc_id = module.network.vpc_id
}

module "app_servers" {
  source             = "./modules/app_servers"
  instance_count     = 4
  security_group_ids = [module.security.security_group_id, module.security.security_group_id, module.security.security_group_id, module.security.private_security_group_id]
  subnet_ids         = [module.network.public_subnets[0], module.network.public_subnets[1], module.network.public_subnets[2], module.network.private_subnets[2]]
  public_ips         = [true, true, true, false]
  instance_names     = ["home-heating", "home-lights", "home-status", "home-auth"]

}


