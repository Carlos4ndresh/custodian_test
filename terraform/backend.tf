terraform {
  backend "s3" {
    bucket = "cloudcustodian-state-bucket"
    key    = "tfstate"
    region = "us-west-2"
  }
}
