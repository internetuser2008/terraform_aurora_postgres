variable "cluster_identifier"{
  description = "Cluster Name for Aurora PostgreSQL database"
  type        = string
}
variable "engine_version"{
  description = "Aurora PostgreSQL database Engine Version"
  type        = string
  default     = "13"
}
variable "multi_az" {
  default     = true
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ."
}
variable "instance_class"{
  description = "Aurora PostgreSQL database instance class"
  type        = string
  default     = "db.m4.large"
}
variable "storage_type" {
  description = "Storage type (e.g. gp2, io1)"
  type        = string
  default     = "gp2"
}
variable "database_name"{
  description = "DB_Name for the Aurora PostgreSQL database"
  type        = string
  default     = "MyApp"
}
variable "master_username"{
  description = "Username for the Aurora PostgreSQL database"
  type        = string
  default     = "Masteruser"
}
variable "preferred_backup_window"{
  description = "preferred time for the Aurora PostgreSQL database backup"
  type        = string
}
variable "backup_retention_period"{
  description = "Backup retention period in days"
  type        = number
  default     = 1
}
variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:32-sun:05:02"
}
variable "skip_final_snapshot"{
  description = "Username for the Aurora PostgreSQL database"
  type        = bool
}
variable "vpc_security_group_ids"{
  description = "VPC to allow connection for the Aurora PostgreSQL database"
  type        = string
}
variable "db_subnet_group_name"{
  description = "Db Subnet group for Aurora PostgreSQL database"
  type        = list(string)
}
variable "storage_encrypted"{
  description = "Encrypted Storage the Aurora PostgreSQL database"
  type        = bool
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
variable "param_log_statement" {
  description = "Sets the type of statements logged. Valid values are none, ddl, mod, all"
  type        = string
  default     = "ddl"
}
variable "param_log_min_duration_statement" {
  description = "(ms) Sets the minimum execution time above which statements will be logged."
  type        = string
  default     = "-1"
}
variable "performance_insights_enabled" {
  default     = false
  type        = bool
  description = "Specifies whether Performance Insights are enabled."
}
variable "performance_insights_retention_period" {
  default     = 7
  type        = number
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
}
variable "tags"{
  description = "Tags applied to PostgreSQL database"
  type        = map(string)
  default     = []
}
variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshots"
  type        = bool
  default     = true
}

