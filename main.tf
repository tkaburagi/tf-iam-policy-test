terraform {
  required_version = " 0.12.6"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "tkaburagi"

    workspaces {
      name = "iam-policy-test"
    }
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}



//resource "aws_iam_policy_attachment" "admin" {
//  name = "admin"
//  roles = [aws_iam_role.role-a.name]
//  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
//}

resource "aws_iam_role_policy_attachment" "admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role = aws_iam_role.role-a.name
}

resource "aws_iam_role" "role-a" {
  name = "role-a"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}