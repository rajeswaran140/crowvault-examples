# modules/orders-db/main.tf
terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  is_production = var.environment == "production"
}

resource "aws_db_subnet_group" "main" {
  name       = var.name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "db" {
  name        = "${var.name}-db"
  description = "PostgreSQL access for ${var.name}"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

# Preferred: allow only the application's security groups.
resource "aws_vpc_security_group_ingress_rule" "from_app" {
  for_each                     = toset(var.app_security_group_ids)
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = each.value
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
  description                  = "PostgreSQL from ${each.value}"
}

# Optional: extra CIDRs (e.g. a VPN range). Empty by default.
resource "aws_vpc_security_group_ingress_rule" "from_cidr" {
  for_each          = toset(var.allowed_cidr_blocks)
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = each.value
  ip_protocol       = "tcp"
  from_port         = 5432
  to_port           = 5432
  description       = "PostgreSQL from ${each.value}"
}

resource "aws_db_instance" "main" {
  identifier            = var.name
  engine                = "postgres"
  engine_version        = "16"
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage # storage autoscaling ceiling
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name                     = replace(var.name, "-", "_")
  username                    = var.username
  manage_master_user_password = true # password generated and rotated in Secrets Manager

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false

  multi_az                              = local.is_production
  backup_retention_period               = local.is_production ? 14 : 1
  copy_tags_to_snapshot                 = true
  deletion_protection                   = local.is_production
  skip_final_snapshot                   = !local.is_production
  final_snapshot_identifier             = "${var.name}-final-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  performance_insights_enabled          = local.is_production
  performance_insights_retention_period = local.is_production ? 7 : null
  auto_minor_version_upgrade            = true

  tags = merge(var.tags, { Environment = var.environment })

  lifecycle {
    # The timestamp keeps each final snapshot name unique without a diff on every plan.
    ignore_changes = [final_snapshot_identifier]
  }
}
