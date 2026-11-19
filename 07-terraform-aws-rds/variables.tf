# modules/orders-db/variables.tf
variable "name" {
  type        = string
  description = "Name prefix for all resources (lowercase letters, digits, hyphens)"
}

variable "environment" {
  type        = string
  description = "development, staging or production"
  default     = "production"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "environment must be development, staging or production."
  }
}

variable "tags" {
  type        = map(string)
  description = "Extra tags/labels"
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC for the database"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnets (at least two AZs)"
}

variable "app_security_group_ids" {
  type        = list(string)
  description = "Security groups of the services that connect (preferred over CIDRs)"
  default     = []
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Extra CIDRs allowed to connect (keep empty if possible)"
  default     = []
}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Initial storage in GiB"
  default     = 20
}

variable "max_allocated_storage" {
  type        = number
  description = "Storage autoscaling ceiling in GiB"
  default     = 100
}

variable "username" {
  type        = string
  description = "Master username"
  default     = "app"
}
