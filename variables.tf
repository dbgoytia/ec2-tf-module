variable "ami" {
  description = "AWS AMI used for deployment"
  type        = string
}
variable "associate_public_ip_address" {
  description = "Wether or not to associate public ip to instance."
  type        = bool
  default     = false
}
variable "az" {
  description = "Availability zone to use for deployment."
  type        = string
}

variable "cloudwatch_agent_enabled" {
  description = "Enable the CloudWatch agent"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "Instance type used for deployment."
  type        = string
}
variable "user_data" {
  description = "Init script to pass base-64 encoded data directly"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags to apply to all AWS resources"
  type        = map(any)
  default     = {}
}
variable "region" {
  description = "Deployment region for AWS resources"
  type        = string
  default     = "us-east-1"
}
variable "subnet_id" {
  description = "Subnet to deploy the EC2 instance to"
  type        = string
}
variable "name" {
  description = "Name to give to the EC2 instance"
  type        = string
}