output "ecr_repo_url" {
  value = aws_ecr_repository.repo.repository_url
}

output "ecs_cluster" {
  value = aws_ecs_cluster.cluster.name
}
