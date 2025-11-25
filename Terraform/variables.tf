variable "public_key" {
  description = "Public key for the EC2 key pair"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "11.0.0.0/16"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0a71e3eb8b23101ed"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Name  = "Infrastructure"
    Owner = "DevOps-Team"
    Email = "devops@nice.com"
  }
}

variable "internet_gateway_enabled" {
  description = "Enable Internet Gateway for the VPC"
  type        = bool
  default     = true
}

variable "route_table_public_enabled" {
  description = "Enable Public Route Table for the VPC"
  type        = bool
  default     = true
}

variable "subnet_cidr_public" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "11.0.1.0/24"
}

variable "network_interface_device_index" {
  description = "Device index for the network interface"
  type        = number
  default     = 0
}

variable "eip_associate" {
  description = "Associate Elastic IP with the instance"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}