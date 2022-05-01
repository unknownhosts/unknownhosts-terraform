resource "aws_iam_role" "bastion" {
	name = "${module.global_variables.this_account_name}-bastion-role"

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

resource "aws_iam_policy" "bastion" {
    name        = "${module.global_variables.this_account_name}-bastion-policy"
    path        = "/"
    description = "for bastionr"

    policy = jsonencode()
}

resource "aws_iam_role_policy_attachment" "bastion" {
    role       = aws_iam_role.bastion.name
    policy_arn = aws_iam_policy.bastion.arn
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${module.global_variables.this_account_name}-bastion-iam-profile"
  role = aws_iam_role.bastion.name
}
