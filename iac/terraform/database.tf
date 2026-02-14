resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnets"
  subnet_ids = aws_subnet.private_db[*].id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-db-subnets"
  })
}

resource "aws_db_instance" "main" {
  identifier               = "${var.project_name}-${var.environment}-db"
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  instance_class           = var.db_instance_class
  allocated_storage        = var.db_allocated_storage
  db_name                  = var.db_name
  username                 = var.db_username
  password                 = var.db_password
  port                     = var.db_port
  db_subnet_group_name     = aws_db_subnet_group.main.name
  vpc_security_group_ids   = [aws_security_group.db.id]
  publicly_accessible      = false
  multi_az                 = var.db_multi_az
  backup_retention_period  = 7
  skip_final_snapshot      = true
  deletion_protection      = false
  auto_minor_version_upgrade = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-db"
  })
}

