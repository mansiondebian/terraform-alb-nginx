# === Variables globales ===

variable "aws_region" {
  description = "Región donde desplegar la infraestructura"
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para alta disponibilidad"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"] # públicas
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
