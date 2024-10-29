terraform {
  backend "s3" {
    bucket         = "terraform-backend-teamcity"
    key            = "terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "DT-terraform-backend-teamcity"
    encrypt        = true
  }
}
