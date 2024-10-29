terraform {
  backend "s3" {
    bucket         = "terraform-backend-teamcity"
    key            = "s3://terraform-backend-teamcity/terraform/"
    region         = "ap-south-1"
    dynamodb_table = "DT-terraform-backend-teamcity"
    encrypt        = true
  }
}
