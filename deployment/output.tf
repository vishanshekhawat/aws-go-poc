output "ecs_cluster" {
  value = aws_ecs_cluster.main.name
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

