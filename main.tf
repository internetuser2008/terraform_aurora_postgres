# Provider configuration
provider "aws" {
  region = var.region
}

# Create the KMS for PostgreSQL cluster
data "aws_kms_key" "db" {
  key_id = var.kms_key_alias
}

# Create the Aurora PostgreSQL cluster
resource "aws_rds_cluster" "aurora_postgres" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = random_password.password.result
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  #skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.db_subnet_group_name
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id
  deletion_protection     = var.deletion_protection
  tags                    = var.tags

  publicly_accessible = false
  deletion_protection  = true
  skip_final_snapshot  = false
 
  # Custom parameter configuration
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Enable enhanced monitoring
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = aws_iam_role.monitoring_role.arn

  # Enable SSL enforcement and APG CCM
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Enable SSL enforcement and APG CCM
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Enable SSL enforcement and APG CCM
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Enable SSL enforcement and APG CCM
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
}

# Create custom parameter group
resource "aws_rds_cluster_parameter_group" "custom_parameter_group" {
  name        = var.custom_parameter_group_name
  family      = var.custom_parameter_group_family
  description = var.custom_parameter_group_description
  tags        = var.tags
}

# Cluster parameters for the Aurora PostgreSQL
resource "aws_rds_cluster_instance" "aurora_postgres_instance" {
  identifier                       = "${var.project_name}-${count.index}"
  cluster_identifier               = aws_rds_cluster.aurora_postgres.id
  instance_class                   = var.instance_class
  engine                           = "aurora-postgresql"
  engine_version                   = var.engine_version
  #engine_mode                     = var.cluster_engine_mode
  kms_key_id                       = data.aws_kms_key.db.arn
  db_subnet_group_name             = var.db_subnet_group_name
  vpc_security_group_ids           = var.vpc_security_group_ids
  monitoring_interval              = var.monitoring_interval
  promotion_tier                   = var.promotion_tier
  performance_insights_kms_key_id  = var.performance_insights_kms_key_id
  tags                             = var.tags
  enabled_cloudwatch_logs_exports  = ["postgresql"]
  count                            = 1
  apply_immediately                = true 
  deletion_protection              = true
  publicly_accessible              = false
  storage_encrypted                = true

}
# Configure custom parameters for the Aurora PostgreSQL cluster
resource "aws_rds_cluster_parameter_group_attachment" "custom_parameter_group_attachment" {
  cluster_identifier = aws_rds_cluster.aurora_postgres.id
  parameter_group_name = aws_rds_cluster_parameter_group.custom_parameter_group.name
}

# Configure custom parameters for the Aurora PostgreSQL instances
resource "aws_rds_cluster_instance_parameter_group" "custom_parameter_group_instance" {
  cluster_identifier = aws_rds_cluster.aurora_postgres.id
  parameter_group_name = aws_rds_cluster_parameter_group.custom_parameter_group.name
}
# Enable SSL enforcement and APG CCM
resource "aws_rds_cluster_instance" "custom_parameter_group_instance" {
  cluster_identifier         = aws_rds_cluster.aurora_postgres.id
  instance_class             = var.instance_class
  engine                     = "aurora-postgresql"
  engine_version             = var.engine_version
  db_subnet_group_name       = var.db_subnet_group_name
  vpc_security_group_ids     = var.vpc_security_group_ids
  apply_immediately          = true
  monitoring_interval        = var.monitoring_interval
  promotion_tier             = var.promotion_tier
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  tags                       = var.tags

  apply_immediately = true
  # Enable SSL enforcement
  parameter_group_name = aws_rds_cluster_parameter_group.custom_parameter_group.name
  parameter {
    name  = "ssl_enforce"
    value = "1"
  }

  # Enable APG CCM
  parameter_group_name = aws_rds_cluster_parameter_group.custom_parameter_group.name
  parameter {
    name  = "apg_ccm_enabled"
    value = "1"
  }
}

# Create a random password for the master user
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create a user with secrets manager rotation
resource "aws_secretsmanager_secret" "user_secret" {
  name = var.user_secret_name
}

resource "aws_secretsmanager_secret_version" "user_secret_version" {
  secret_id     = aws_secretsmanager_secret.user_secret.id
  secret_string = jsonencode({
    "username" = var.user_username
    "password" = random_password.user_password.result
  })
}

resource "aws_secretsmanager_rotation_schedule" "user_secret_rotation" {
  secret_id               = aws_secretsmanager_secret.user_secret.id
  rotation_lambda_arn     = var.rotation_lambda_arn
  rotation_rules          = var.rotation_rules
  rotation_single_user    = var.rotation_single_user
  rotation_single_user_id = var.rotation_single_user_id
}

# Create IAM role for enhanced monitoring
resource "aws_iam_role" "monitoring_role" {
  name = var.monitoring_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "monitoring.rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create IAM policy for enhanced monitoring
resource "aws_iam_policy" "monitoring_policy" {
  name        = var.monitoring_policy_name
  description = "Policy for enhanced monitoring"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "monitoring_policy_attachment" {
  role       = aws_iam_role.monitoring_role.name
  policy_arn = aws_iam_policy.monitoring_policy.arn
}

# Create security group
resource "aws_security_group" "aurora_sg" {
  name        = var.security_group_name
  description = "Security group for Aurora PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

}
