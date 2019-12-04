provider "aws" {
    region = "us-west-2"
    profile = "endava"  
    # TODO put assume role
}


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


// TODO Restrict more Permissions to cloudcustodian
resource "aws_iam_policy" "lambda_policy" {
  name = "cloudcustodian-lambda-policy"
  policy = file("./iampolicy.json")
}

resource "aws_iam_role_policy_attachment" "custodian_policy_attachment" {
  role       = "${aws_iam_role.cloudcustodian_lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

resource "aws_s3_bucket" "cloudcustodian_bucket" {
  bucket = "cloudcustodian-lambda-bucket-logs"
  acl    = "private"

  tags = {
      owner = "cherrera",
      cost-center= "cherrera",
      app-name = "cloudcustodian"
  }
}