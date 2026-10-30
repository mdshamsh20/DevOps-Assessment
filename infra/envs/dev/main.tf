resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "network" {
  source = "../../modules/network"

  name               = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  nat_gateway_count  = var.nat_gateway_count
}

module "ecs" {
  source = "../../modules/ecs"

  name               = var.environment
  aws_region         = var.aws_region
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  container_image    = var.container_image
  task_cpu           = var.task_cpu
  task_memory        = var.task_memory
  desired_count      = var.desired_count
}

module "rds" {
  source = "../../modules/rds"

  name                    = var.environment
  vpc_id                  = module.network.vpc_id
  private_subnet_ids      = module.network.private_subnet_ids
  ecs_security_group_id   = module.ecs.ecs_security_group_id
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
  multi_az                = var.db_multi_az
  db_name                 = var.db_name
  username                = var.db_username
  password                = random_password.db.result
}
