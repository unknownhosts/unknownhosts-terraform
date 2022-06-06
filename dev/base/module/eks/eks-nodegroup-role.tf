
resource "aws_iam_role" "eks_node" {
	name = "${module.global_variables.this_cluster_name}-node-role"

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


resource "aws_iam_role_policy" "cluster_autoscaling" {
    name = "${module.global_variables.this_cluster_name}-node-CA-role"
    role = aws_iam_role.eks_node.name

    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {

            "Effect": "Allow",
        
            "Action": [
        
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
             ],
        
            "Resource": "*"
        
            }
        
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_node" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node_ecr" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node_sms" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
    role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node_ses" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
    role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node_cni" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.eks_node.name
}

