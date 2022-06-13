locals {
    node_group_defaults = {

       # iam_role_additional_policies = [
       #     aws_iam_policy.eks_ca_asg_policy.arn,
       #     aws_iam_policy.ebs_csi_driver.arn,
       #     aws_iam_policy.storage.arn,
       # ]

        ami_type       = "AL2_x86_64"
        instance_types = ["t3.large"]
        

        security_group_use_name_prefix  = "false"
        use_name_prefix                 = "false"
        launch_template_use_name_prefix = "false"
        iam_role_use_name_prefix        = "false"

        attach_cluster_primary_security_group = true
        #vpc_security_group_ids                = [aws_security_group.additional.id]
        
         /* remote_access = {
            source_security_group_ids = [data.terraform_remote_state.mgmt_sg.outputs.dev_atlantis_sg_id]
        }  */

        block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 100
            volume_type           = "gp3"
                }
            }
        }

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
    } 

    node_groups = {
        ingress = {
            name = "${var.project_name}-${var.resource_name}-${var.environment_name}-ingress-node"
            min_size     = 1
            max_size     = 1
            desired_size = 1

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "ingress"
            }

            update_config = {
                max_unavailable_percentage = 50 # or set `max_unavailable`
            }

            # user data
            enable_bootstrap_user_data = true
            bootstrap_extra_args       = "--container-runtime containerd --kubelet-extra-args '--max-pods=20'"
            user_data_template_path = "userdata/init.sh"

            /* create_launch_template = "false" 
            launch_template_name   = aws_launch_template.ingress.name   */

            tags = merge(
                {
                    "Name" = "${var.project_name}-${var.resource_name}-${var.environment_name}-ingress-node"
                },
                    var.tags,
                ),
        }

        app = {
            name = "${var.project_name}-${var.resource_name}-${var.environment_name}-app-node"
            min_size     = 1
            max_size     = 1
            desired_size = 1

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "app"
            }

            update_config = {
                max_unavailable_percentage = 50 # or set `max_unavailable`
            }

            # user data
            enable_bootstrap_user_data = true
            bootstrap_extra_args       = "--container-runtime containerd --kubelet-extra-args '--max-pods=20'"
            user_data_template_path = "userdata/init.sh"
            
            /* create_launch_template = "false"
            launch_template_name = aws_launch_template.app.name */

            tags = merge(
                {
                    "Name" = "${var.project_name}-${var.resource_name}-${var.environment_name}-app-node"
                },
                    var.tags,
                ),
        }
    
        mgmt = {
            name = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-node"
            min_size     = 1
            max_size     = 1
            desired_size = 1

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "mgmt"
            }

            update_config = {
                max_unavailable_percentage = 50 # or set `max_unavailable`
            }

            # user data
            enable_bootstrap_user_data = true
            bootstrap_extra_args       = "--container-runtime containerd --kubelet-extra-args '--max-pods=20'"
            user_data_template_path = "userdata/init.sh"

            /* create_launch_template = "false"
            launch_template_name = aws_launch_template.mgmt.name */


            tags = merge(
                {
                    "Name" = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-node"
                },
                    var.tags,
                ),
        }
    }
}