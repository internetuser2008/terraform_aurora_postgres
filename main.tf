resource "aws_db_instance" "aurora_postgres" {
  engine               = "aurora-postgresql"
  engine_version       = "11.9"
  instance_class       = "db.r5.large"
  allocated_storage    = 100
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = aws_db_parameter_group.aurora_parameter_group.name
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  apply_immediately    = true
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
  name   = "aurora_parameter_group"
  family = "aurora-postgresql11"

  parameter {
    name  = "ssl_enforce"
    value = "1"
  }
}

resource "aws_security_group" "aurora_sg" {
  name        = "aurora_sg"
  description = "Security group for Aurora PostgreSQL"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
