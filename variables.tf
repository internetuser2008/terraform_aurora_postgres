variable "cluster_identifier"{
  description = "Cluster Name for Aurora PostgreSQL database"
  type        = string
}
variable "engine_version"{
  description = "Aurora PostgreSQL database Engine Version"
  type        = string
}
variable "database_name"{
  description = "DB_Name for the Aurora PostgreSQL database"
  type        = string
  default     = "MyApp"
}
variable "master_username"{
  description = "Username for the Aurora PostgreSQL database"
  type        = string
}
variable "preferred_backup_window"{
  description = "preferred time for the Aurora PostgreSQL database backup"
  type        = string
}
variable "backup_retention_period"{
  description = "Backup_retention for the Aurora PostgreSQL database"
  type        = string
}
variable "skip_final_snapshot"{
  description = "Username for the Aurora PostgreSQL database"
  type        = string
}
variable "vpc_security_group_ids"{
  description = "VPC to allow connection for the Aurora PostgreSQL database"
  type        = string
}
variable "db_subnet_group_name"{
  description = "Db Subnet group for Aurora PostgreSQL database"
  type        = string
}
variable "storage_encrypted"{
  description = "Encrypted Storage the Aurora PostgreSQL database"
  type        = string
  default     = "yes"
}
variable "kms_key_id"{
  description = "Encrypt Key on storage for Aurora PostgreSQL database"
  type        = string
}
variable "deletion_protection"{
  description = "Accidental delete protection for Aurora PostgreSQL database"
  type        = string
  default     = "true"
}
variable "tags"{
  description = "Tags applied to PostgreSQL database"
  type        = string
  default     = []
}
