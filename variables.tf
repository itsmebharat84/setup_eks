variable "aws_region" {
  type = string
}
variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "name" {
  type    = string
  default = "setup-eks"
}

variable "vpc_cidr" {
  type    = string
  default = "10.17.0.0/24"
}

variable "az_count" {
  type    = number
  default = 3
}

variable "subnet_cidr_bits" {
  type    = number
  default = 5
}
