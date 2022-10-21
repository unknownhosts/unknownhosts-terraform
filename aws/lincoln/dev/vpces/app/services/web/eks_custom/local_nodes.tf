locals {
    node_group_defaults = {

       iam_role_additional_policies = [
           data.terraform_remote_state.iampolicy.outputs.ecr_test.arn
       ]

        ami_type       = "AL2_x86_64"
        instance_types = ["t3.large"]
        

        security_group_use_name_prefix  = "false"
        use_name_prefix                 = "false"
        launch_template_use_name_prefix = "false"
        iam_role_use_name_prefix        = "false"

        attach_cluster_primary_security_group = true

        pre_bootstrap_user_data = file("userdata/pre_user_data.sh")

        key_name = data.terraform_remote_state.keypair.outputs.key_pair

        /* update_config = {
            max_unavailable_percentage = 50 # or set `max_unavailable`
        } */

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
        }
    } 

    node_groups = {
        ingress = {
            name = "${var.project_name}-${var.resource_name}-${var.environment_name}-ingress-node"
            min_size     = 1
            max_size     = 2
            desired_size = 2

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "ingress"
            }

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
            max_size     = 2
            desired_size = 2

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "app"
            }

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
            max_size     = 2
            desired_size = 2

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "mgmt"
            }

            tags = merge(
                {
                    "Name" = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-node"
                },
                    var.tags,
                ),
        }

        test2 = {

            name = "${var.project_name}-${var.resource_name}-${var.environment_name}-test2-node"
            min_size     = 1
            max_size     = 1
            desired_size = 1

            pre_bootstrap_user_data = file("userdata/pre_user_data_test.sh")

            instance_types = ["t3.large"]
            labels = {
                "node-group" = "test2"
            }

            tags = merge(
                {
                    "Name" = "${var.project_name}-${var.resource_name}-${var.environment_name}-test2-node"
                },
                    var.tags,
                ),
        }

    }
}