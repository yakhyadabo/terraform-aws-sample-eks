variable "region" {
  type = string
  default = "us-east-1"
}

variable "environment" {
  type = string
  description = "Deployment Environment"
}

variable "service_name" {
  type = string
  description = "The name of the EKS cluster"
  default = "eks-cluster"
}

variable "vpc_name" {
  type = string
  description = "The name of the vpc"
}

variable "key_name" {
  type = string
  description = "Name of the key pair created in AWS"
}

################################################################

variable "endpoint_private_access" {
  type = bool
  default = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "endpoint_public_access" {
  type = bool
  default = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
  type = string
  default = "AL2_x86_64"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes. Defaults to 20."
  type = number
  default = 20
}

variable "volume_type" {
  description = "Volume type for worker nodes. Default to gp2"
  type = string
  default = "gp2"
}

variable "instance_types" {
  type = list(string)
  default = ["t3.medium"]
  description = "Set of instance types associated with the EKS Node Group."
}

variable "private_desired_size" {
  description = "Desired number of worker nodes in private subnet"
  default = 1
  type = number
}

variable "private_max_size" {
  description = "Maximum number of worker nodes in private subnet."
  default = 1
  type = number
}

variable "private_min_size" {
  description = "Minimum number of worker nodes in private subnet."
  default = 1
  type = number
}

variable "public_desired_size" {
  description = "Desired number of worker nodes in public subnet"
  default = 1
  type = number
}

variable "public_max_size" {
  description = "Maximum number of worker nodes in public subnet."
  default = 1
  type = number
}

variable "public_min_size" {
  description = "Minimum number of worker nodes in public subnet."
  default = 1
  type = number
}

variable cluster_sg_name {
  description = "Name of the EKS cluster Security Group"
  type        = string
}

variable nodes_sg_name {
  description = "Name of the EKS node group Security Group"
  type        = string
}