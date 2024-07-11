data "aws_ecr_repository" "repos" {
  for_each = toset(local.list_repo)
  name     = each.value
}
