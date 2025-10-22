data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.app_name}-task-exec-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

# attach the managed policy AmazonECSTaskExecutionRolePolicy
resource "aws_iam_role_policy_attachment" "exec_role_attach" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
