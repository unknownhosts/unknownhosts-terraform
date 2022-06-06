resource "aws_eks_cluster" "this" {
	name     = "${module.global_variables.this_cluster_name}"
	role_arn = aws_iam_role.eks.arn
	version = "1.21"

	enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

	depends_on = [
		aws_iam_role_policy_attachment.eks_cluster,
		aws_iam_role_policy_attachment.eks_vpc_controller,
	]

	vpc_config {
		subnet_ids         = [
			"${module.global_variables.this_pangaia_b4c_vpc_info.outputs.this_pri_sbnt_a_id}", 
			"${module.global_variables.this_pangaia_b4c_vpc_info.outputs.this_pri_sbnt_b_id}", 
			"${module.global_variables.this_pangaia_b4c_vpc_info.outputs.this_pri_sbnt_c_id}" 
		]
		endpoint_private_access = true
		endpoint_public_access = false
	}
}


resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name        = "kube-proxy"
  addon_version     = "v1.21.2-eksbuild.2"
  resolve_conflicts = "OVERWRITE"  

}

## 최초 사용 시에만 node role 이용해 cni 생성 후, 수기로 eks service account 생성하여 콘솔에서 sa role로 cni 생성 (노션 참고)
# resource "aws_eks_addon" "vpc_cni" {
#   cluster_name = aws_eks_cluster.this.name
#   addon_name        = "vpc-cni"
#   addon_version     = "v1.10.1-eksbuild.1"
#   resolve_conflicts = "OVERWRITE"  
# }

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name        = "coredns"
  addon_version     = "v1.8.4-eksbuild.1"
  resolve_conflicts = "OVERWRITE"  

}
