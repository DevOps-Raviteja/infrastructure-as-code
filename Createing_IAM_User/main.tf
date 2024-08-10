provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_user" "iam_user" {
    name = "DevOps_user_1"
}

resource "aws_iam_access_key" "iam_access_key" {
    user = aws_iam_user.iam_user.name
}

data "aws_iam_policy_document" "policy_document"{
    statement {
        actions = [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
        ]
        resources = [
            "*"
        ]
    }
}

resource "aws_iam_user_policy" "s3_get_put_delete_policy_document" {
    name = "s3_access"
    user = aws_iam_user.iam_user.name
    policy = data.aws_iam_policy_document.policy_document.json
}