/* 
security_group_rules = {
            egress_cluster_443 = {
                description                   = "Node groups to cluster API"
                protocol                      = "tcp"
                from_port                     = 443
                to_port                       = 443
                type                          = "egress"
                source_cluster_security_group = true
            }

            ingress_cluster_443 = {
                description                   = "Cluster API to node groups"
                protocol                      = "tcp"
                from_port                     = 443
                to_port                       = 443
                type                          = "ingress"
                source_cluster_security_group = true
            }

            ingress_cluster_kubelet = {
                description                   = "Cluster API to node kubelets"
                protocol                      = "tcp"
                from_port                     = 10250
                to_port                       = 10250
                type                          = "ingress"
                source_cluster_security_group = true
            }

            ingress_self_coredns_tcp = {
                description = "Node to node CoreDNS"
                protocol    = "tcp"
                from_port   = 53
                to_port     = 53
                type        = "ingress"
                self        = true
            }

            egress_self_coredns_tcp = {
                description = "Node to node CoreDNS"
                protocol    = "tcp"
                from_port   = 53
                to_port     = 53
                type        = "egress"
                self        = true
            }

            ingress_self_coredns_udp = {
                description = "Node to node CoreDNS"
                protocol    = "udp"
                from_port   = 53
                to_port     = 53
                type        = "ingress"
                self        = true
            }

            egress_self_coredns_udp = {
                description = "Node to node CoreDNS"
                protocol    = "udp"
                from_port   = 53
                to_port     = 53
                type        = "egress"
                self        = true
            }

            egress_https = {
                description      = "Egress all HTTPS to internet"
                protocol         = "tcp"
                from_port        = 443
                to_port          = 443
                type             = "egress"
                cidr_blocks      = ["0.0.0.0/0"]
            }

            egress_ntp_tcp = {
                description      = "Egress NTP/TCP to internet"
                protocol         = "tcp"
                from_port        = 123
                to_port          = 123
                type             = "egress"
                cidr_blocks      = ["0.0.0.0/0"]
            }

            egress_ntp_udp = {
                description      = "Egress NTP/UDP to internet"
                protocol         = "udp"
                from_port        = 123
                to_port          = 123
                type             = "egress"
                cidr_blocks      = ["0.0.0.0/0"]
            }
        }




resource "aws_security_group" "node" {
  name        = "${var.project_name}-${var.resource_name}-${var.environment_name}-eks-node-all"
  description = "${var.project_name}-${var.resource_name}-${var.environment_name}-eks-node-all"
  
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc[0].vpc_id

}



resource "aws_security_group_rule" "node" {
  for_each = { for k, v in merge(local.node_security_group_rules, var.node_security_group_additional_rules) : k => v }

  # Required
  security_group_id = aws_security_group.node[0].id
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  type              = each.value.type

  # Optional
  description      = try(each.value.description, null)
  cidr_blocks      = try(each.value.cidr_blocks, null)
  ipv6_cidr_blocks = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids  = try(each.value.prefix_list_ids, [])
  self             = try(each.value.self, null)
  source_security_group_id = try(
    each.value.source_security_group_id,
    try(each.value.source_cluster_security_group, false) ? local.cluster_security_group_id : null
  )

    tags = merge(
        {
            Name = "${var.project_name}-${var.resource_name}-mgmt-atlantis-sg"
        },
        var.tags
        )
} */