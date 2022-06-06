
resource "aws_eks_node_group" "b4c-auth" {
	cluster_name    = "${module.global_variables.this_cluster_name}"
	node_group_name = "${module.global_variables.this_cluster_name}-b4c-auth"
	node_role_arn   = aws_iam_role.eks_node.arn
	subnet_ids      = [
		"${module.global_variables.this_pangaia_b4c_vpc_info.outputs.this_pri_sbnt_a_id}",
		"${module.global_variables.this_pangaia_b4c_vpc_info.outputs.this_pri_sbnt_b_id}",
		"${module.global_variables.this_pangaia_b4c_vpc_info.outputs.this_pri_sbnt_c_id}" 
	]
	instance_types = ["t3.medium"]

	remote_access {
		ec2_ssh_key = "${module.global_variables.this_cluster_name}"
	}
	
	disk_size = 50

	labels = {
		"nodegroup-type" = "B4C-AUTH"
	}

	depends_on = [
		aws_iam_role_policy_attachment.eks_node,
		aws_iam_role_policy_attachment.eks_node_ecr
	]

	scaling_config {
		desired_size = 1
		min_size     = 1
		max_size     = 20
	}

	tags = {
	"Name" = "${module.global_variables.this_cluster_name}-b4c-auth"
	}

    lifecycle {
        ignore_changes = [scaling_config]
    }
}