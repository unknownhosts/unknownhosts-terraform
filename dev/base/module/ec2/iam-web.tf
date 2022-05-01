resource "aws_iam_role" "web" {
	name = "${module.global_variables.this_account_name}-web-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "web" {
    name        = "${module.global_variables.this_account_name}-web-policy"
    path        = "/"
    description = "web"

    policy = jsonencode()
}

resource "aws_iam_role_policy_attachment" "web" {
    role       = aws_iam_role.web.name
    policy_arn = aws_iam_policy.web.arn
}

resource "aws_iam_instance_profile" "web" {
  name = "${module.global_variables.this_account_name}-web-iam-profile"
  role = aws_iam_role.web.name
}
