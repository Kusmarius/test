
module "vpc_dev" {
  project_name      = var.project_name
  env               = "dev"
  cidr_block        = "10.0.0.0/22"
  private_subnet_a  = "10.0.0.0/24"
  public_subnet_a   = "10.0.1.0/24"
  private_subnet_b  = "10.0.2.0/24"
  public_subnet_b   = "10.0.3.0/24"
  domain_name = "${var.domain_name}"
  source = "../modules/vpc"
}


module "ecs" {
  project_name       = var.project_name
  env                = var.env
  ecs_cluster        = "${var.project_name}-${var.env}"
  source             = "../modules/ecs"
  vpc_id             = "${module.vpc_dev.vpc_id}"
  public_subnet_ids  = "${module.vpc_dev.public_subnet_ids}"
  private_subnet_ids = "${module.vpc_dev.private_subnet_ids}"
}

#module "dev_envs_ecs_deploy" {
#  source = "../modules/dev_envs_ecs_deploy"
#  lb_listener_arn = "${module.dev_envs_ecs.lb_listener_arn}"
#  ecs_cluster_id = "${module.dev_envs_ecs.ecs_cluster_id}"
#  source_branch = "${var.source_branch}"
#  vpc_id = "${module.vpc_dev.vpc_id}"
#  public_subnet_ids = "${module.vpc_dev.public_subnet_ids}"
#  private_subnet_ids = "${module.vpc_dev.private_subnet_ids}"
#  key_pair_name = "${var.key_pair_name}"
#}
