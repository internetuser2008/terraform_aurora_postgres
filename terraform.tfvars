#User values of varaiable used for Aurora Postgres Database

# AuroraDB
aws_region = "us-east-1"
vpc_cidr_block = "10.0.0.0/16"
cluster_identifier = "DB_App"
engine_version  = "13.6"
instance_class = "db.t3.medium"
database_name = "app1"
master_username = "admin"
backup_retention_period  = "7"
preferred_backup_window  = "02:00-03:00"
maintenance_window = "sun:04:32-sun:05:02"
skip_final_snapshot = "False"
vpc_security_group_ids  = "10.0.0.0/16"
db_subnet_group_name  = "["10.0.3.0/24", "10.0.4.0/24"]"
storage_encrypted  = "True"
kms_key_id  = ""
deletion_protection  = "True"
tags  = ""

secondary_instance_count = 1
auto_minor_version_upgrade = "True"
enable_postgresql_log = "True"
