variable "region" {
  default = "us-east-1"
}

variable "project" {
  type = object({
    name = string
    team      = string
    contact_email  = string
    environment = string
  })

  description = "Project details"
}

variable "service_name" {
  type = string
  description = "The name of the service deployed with the ELB"
}

variable "key_name" {
  type = string
  description = "Name of the key pair created in AWS"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24","10.0.10.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.2.0/24","10.0.20.0/24"]
}