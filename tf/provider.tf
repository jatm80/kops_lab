terraform {
  backend "s3" {}
}

provider "aws" {
  profile = "aws-cert1"
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}

provider "null" {}