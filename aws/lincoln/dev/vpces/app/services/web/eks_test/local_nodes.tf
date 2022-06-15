/* data "template_file" "userdata" {
    template = file("userdata/init.tpl")
    vars = {
      cluster_name              = module.eks.cluster_id
      bootstrap_extra_args      = "--container-runtime containerd --kubelet-extra-args '--max-pods=20'"
      post_bootstrap_user_data  = "userdata/init_post.tpl"
    }
} */

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

        key_name = data.terraform_remote_state.keypair.outputs.key_pair
        pre_bootstrap_user_data = file("userdata/init_pre.sh")
        
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
                description                   = "Custom Rules"
                protocol                      = "tcp"
                from_port                     = 443
                to_port                       = 443
                type                          = "egress"
                source_cluster_security_group = true
            }

            ingress_cluster_443 = {
                description                   = "Custom Rules"
                protocol                      = "tcp"
                from_port                     = 443
                to_port                       = 443
                type                          = "ingress"
                source_cluster_security_group = true
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

            /* create_launch_template = "false" 
            launch_template_name   = aws_launch_template.ingress.name   */

            # user data
            /* enable_bootstrap_user_data = true
            user_data_template_path = "userdata/init.tpl"
            bootstrap_extra_args      = "--use-max-pods false --container-runtime containerd --kubelet-extra-args --max-pods=20'"
             '--node-labels=eks.amazonaws.com/nodegroup=${var.project_name}-${var.resource_name}-${var.environment_name}-ingress-node,
            eks.amazonaws.com/nodegroup-image=${var.eks_ami_id},
            eks.amazonaws.com/capacityType=ON_DEMAND,
            eks.amazonaws.com/sourceLaunchTemplateVersion=6,
            eks.amazonaws.com/sourceLaunchTemplateId=lt-008062a4e28aad130 --max-pods=20' 
            --dns-cluster-ip $K8S_CLUSTER_DNS_IP" 
            pre_bootstrap_user_data = file("userdata/init_pre.sh")
            post_bootstrap_user_data = file("userdata/init_post.sh") */

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

            /* create_launch_template = "false"
            launch_template_name = aws_launch_template.app.name */
            
            # user data
            /* enable_bootstrap_user_data = true
            user_data_template_path = "userdata/init.tpl"
            bootstrap_extra_args      = "--use-max-pods false 
            --container-runtime containerd 
            --kubelet-extra-args '--node-labels=eks.amazonaws.com/nodegroup=${var.project_name}-${var.resource_name}-${var.environment_name}-app-node,
            eks.amazonaws.com/nodegroup-image=${var.eks_ami_id} --max-pods=20' 
            --dns-cluster-ip $K8S_CLUSTER_DNS_IP" 
            pre_bootstrap_user_data = file("userdata/init_pre.sh")
            post_bootstrap_user_data = file("userdata/init_post.sh") */

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

            /* create_launch_template = "false"
            launch_template_name = aws_launch_template.mgmt.name */


            /* # user data
            enable_bootstrap_user_data = true
            #user_data_template_path = "userdata/init.tpl"
            bootstrap_extra_args      = "--use-max-pods false --container-runtime containerd --kubelet-extra-args '--max-pods=20'"
            pre_bootstrap_user_data = file("userdata/init_pre.sh")
            post_bootstrap_user_data = file("userdata/init_post.sh") */

            tags = merge(
                {
                    "Name" = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-node"
                },
                    var.tags,
                ),
        }
    }
}