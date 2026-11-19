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

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDRs allowed to connect"
  default     = ["10.0.0.0/16"]
}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Storage in GiB"
  default     = 20
}

variable "username" {
  type        = string
  description = "Master username"
  default     = "app"
}
