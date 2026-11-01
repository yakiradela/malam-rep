variable "aws_region" {
  type        = string
  description = "AWS Deployment"
  default     = "us-east-2"
}

variable "environment" {
  type        = string
  description = "Environment deployment"
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block"
  default     = "10.0.0.0/16"
}

variable "domain_name" {
  type        = string
  description = "Application root domain name"
  default     = "demoapp.com"
}
