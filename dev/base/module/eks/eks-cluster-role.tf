resource "aws_iam_role" "eks" {
	name = "${module.global_variables.this_cluster_name}-role"

	assume_role_policy = <<POLICY
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Service": "eks.amazonaws.com"
			},
			"Action": "sts:AssumeRole"
		}
	]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
	policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
	role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_controller" {
	policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
	role       = aws_iam_role.eks.name
}
