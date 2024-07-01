# Github action IAM User
resource "aws_iam_user" "github_actions_user" {
  name = var.aws_user.name
  tags = var.common_tags
}


resource "aws_iam_access_key" "github_actions_user_access_key" {
  user = aws_iam_user.github_actions_user.name
}

resource "aws_iam_policy" "github_actions_user_access_policy" {
  name = "github-actions-user-access-policy"
  depends_on = [
    module.weather_wiz_app_repository
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push.html
        Effect = "Allow",
        Action = [
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:InitiateLayerUpload",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage"
        ],
        Resource = [
          for repository in module.weather_wiz_app_repository : repository.repository_arn
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = ["*"]
      },
      {
        Effect = "Allow",
        Action = [
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeServices",
          "ecs:UpdateService"
        ],
        Resource = [
          "*",
        ]
      },
      {
        Effect = "Allow",
        Resource = [
          "*",
        ]
        Action = [
          "iam:PassRole"
        ],
        # # Resource = [aws_iam_role.ecs_task_execution_role.arn],
        # Condition = {
        #   StringEquals = {
        #     "iam:PassedToService" : "ecs-tasks.amazonaws.com"
        #   }
        # }
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "github_actions_user_policy_attach" {
  name = "github-actions-user-policy-attach"
  users = [
    aws_iam_user.github_actions_user.name
  ]
  policy_arn = aws_iam_policy.github_actions_user_access_policy.arn
}