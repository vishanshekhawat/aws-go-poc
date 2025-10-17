resource "aws_ecr_repository" "aws_go_poc" {
  name                 = "aws-go-poc"
  image_tag_mutability = "MUTABLE" # or "IMMUTABLE" based on your requirement
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true # Allows deletion of non-empty repositories
}


