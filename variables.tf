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
