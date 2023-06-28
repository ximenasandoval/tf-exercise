variable "region" {
  description = "AWS region in which to create VPC"
  default     = "us-east-1"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block to use for VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "project" {
  description = "Project name"
  type = string
  default = ""
}