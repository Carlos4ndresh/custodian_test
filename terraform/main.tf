provider "aws" {
    region = "us-west-2"
    profile = "endava"  
}


# Resources needed for cloudcustodian
## IAM Role for Lambdas to control other resources
### S3 or EBS? To store cloudcustodian execution logs, besides cloudwatch access in the previous pint

resource "aws_iam_role" "cloudcustodian_lambda_role" {
  name = "cloudcustodian_lambda_role"
  max_session_duration = 3600   

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY

  tags = {
      owner = "cherrera",
      cost-center= "cherrera",
      app-name = "cloudcustodian"
  }
}


data "aws_iam_policy" "example" {
  policy = file("./iampolicy.json")
}