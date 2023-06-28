variable "vpc_id" {
  description = "VPC ID in which to place resources in"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID in which to place ALB"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID in which to place ALB"
  type        = string
}

variable "region" {
  description = "AWS region in which to place resources in"
  type        = string
  default     = "us-east-1"
}

variable "asg_cooldown" {
  description = "ASG cooldown time in seconds"
  type        = number
  default     = 300
}

variable "asg_desired_capacity" {
  description = "ASG desired capacity"
  type        = number
  default     = 2
}

variable "asg_min_size" {
  description = "ASG minimum capacity"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "ASG maximum capacity"
  type        = number
  default     = 2
}

variable "name" {
  description = "Name of the ASG"
  type        = string
}


variable "alb_port" {
  description = "ALB port"
  type        = number
  default     = 80
}

variable "deregistration_delay" {
  description = "ALB deregistration delay"
  type        = number
  default     = 300
}

variable "project" {
  description = "Project name"
  type        = string
  default     = ""
}
