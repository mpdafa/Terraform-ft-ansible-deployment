terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# Use credential files instead of defining in this file

# Set-Location $env:USERPROFILE
# cd .\.aws\

provider "aws" {
  region = "us-east-1"
  # shared_config_files      = ["~/.aws/conf"]
  shared_credentials_files = ["~/.aws/credentials"]
  # profile                  = "vscode"
}