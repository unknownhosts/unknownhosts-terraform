resource "aws_iam_role" "was" {
	name = "${module.global_variables.this_account_name}-was-role"

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

resource "aws_iam_policy" "was" {
    name        = "${module.global_variables.this_account_name}-was-policy"
    path        = "/"
    description = "was"

    policy = jsonencode()
}

resource "aws_iam_role_policy_attachment" "was" {
    role       = aws_iam_role.was.name
    policy_arn = aws_iam_policy.was.arn
}

resource "aws_iam_instance_profile" "was" {
  name = "${module.global_variables.this_account_name}-was-iam-profile"
  role = aws_iam_role.was.name
}
