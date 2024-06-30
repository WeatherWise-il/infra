
module "weather_wiz_app_repository" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"
  for_each = toset(["weather_wiz_app_backend", "weather_wiz_app_frontend", "weather_wiz_app_db", "weather_wiz_app_nginx"])
  repository_name                 = each.key
  repository_type                 = var.weather_wiz_vpc_ecr_repository.repository_type
  repository_image_tag_mutability = "IMMUTABLE"
  create_lifecycle_policy         = true

  # only keep the latest 5 images
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images by count"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = merge(var.common_tags)
}




