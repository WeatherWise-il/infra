output "vpc_ecr_repository_url" {
   value = { for name, repo in module.weather_wiz_app_repository : name => repo.repository_url }                    
}

output "ecr_repository_arn" {
  value = { for name, repo in module.weather_wiz_app_repository : name => repo.repository_arn }
}


