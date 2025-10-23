variable "aws_region" {
  type    = string
  default = "ap-south-1" # change if needed
}

variable "app_name" {
  type    = string
  default = "aws-go-poc-simple-ecs"
}

variable "container_port" {
  type    = number
  default = 8080
}
