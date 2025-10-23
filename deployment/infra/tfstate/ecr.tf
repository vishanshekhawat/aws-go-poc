resource "aws_ecr_repository" "repo" {
  name                 = var.app_name
  image_tag_mutability = "MUTABLE"
  tags                 = { Name = var.app_name }
  force_delete         = true # Allows deletion of the repository with images
}

variable "app_name" {
  type    = string
  default = "aws-go-poc-simple-ecs"
}
