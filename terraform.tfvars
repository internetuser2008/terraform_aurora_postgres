#User values of varaiable used for Aurora Postgres Database

# AuroraDB
aws_region = "us-east-1"
vpc_cidr_block = "10.0.0.0/16"
cluster_identifier = "DB_App"
engine_version  = "11.9"
database_name = "app1"
master_username = "admin"
backup_retention_period  = ""
preferred_backup_window  = ""
skip_final_snapshot = "False"
vpc_security_group_ids  = "10.0.0.0/16"
db_subnet_group_name  = ""
storage_encrypted  = "True"
kms_key_id  = ""
deletion_protection  = "True"
tags  = ""
