variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to deploy"
}

variable "name" {
  type        = string
  default     = "varun"
  description = "My name"
}

variable "purpose" {
  type        = string
  default     = "web-site"
  description = "Hosting a website"
}

variable "ami_id" {
  type        = string
  default     = "ami-0440d3b780d96b29d"
  description = "Amazon Linux 2023 AMI 2023.3.20240219.0 x86_64 HVM kernel-6.1"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidrs" {
  type        = string
  description = "Private Subnet CIDR values"
  default     = "10.0.2.0/24"
}

variable "az" {
  type        = string
  description = "Availability Zones"
  default     = "us-east-1a"
}
