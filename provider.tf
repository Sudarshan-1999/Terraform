terraform {
  required_providers {
    aws = {
        # source = "hashicorp/aws"
        source = "hashicorp/aws"
        version =  "5.68.0"
    }
  }
}
provider "aws" {
    region = var.region
    access_key = "add access key"
    secret_key = "add secret key"
}
