# --- IAM Role for AWS Batch Execution ---
resource "aws_iam_role" "aws_go_poc_role" {
  name = "aws-go-poc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ecs-tasks.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# --- Custom Policy for S3, DynamoDB, and EventBridge ---
resource "aws_iam_policy" "aws_go_poc_policy" {
  name = "aws-go-poc-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
          "dynamodb:*",
          "batch:*",
          "logs:*",
          "events:*",
          "ecs:*",
          "ec2:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = "*"
        Condition = {
          StringLike = {
            "iam:PassedToService" = [
              "ecs-tasks.amazonaws.com",
            ]
          }
        }
      }
    ]
  })
}


# --- Attach Custom Policy to Role ---
resource "aws_iam_role_policy_attachment" "batch_custom_attach" {
  role       = aws_iam_role.aws_go_poc_role.name
  policy_arn = aws_iam_policy.aws_go_poc_policy.arn
}

