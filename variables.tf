variable "db_name" {
  description = "Name of the Aurora PostgreSQL database"
  type        = string
}

variable "db_username" {
  description = "Username for the Aurora PostgreSQL database"
  type        = string
}

variable "db_password" {
  description = "Password for the Aurora PostgreSQL database"
  type        = string
}

  cluster_identifier      = var.cluster_identifier
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = random_password.password.result
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.db_subnet_group_name
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id
  deletion_protection     = var.deletion_protection
  tags                    = var.tags
