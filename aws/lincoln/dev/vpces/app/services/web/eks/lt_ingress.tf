
resource "aws_launch_template" "ingress" {
  #name_prefix            = "${var.env_name}-frontend-eks-node-lt"
  name = "${var.project_name}-lt-${var.environment_name}-ingress-node"
  description            = "ingress Launch-Template"
  update_default_version = true
  key_name = data.terraform_remote_state.keypair.outputs.key_pair
  
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 50
      volume_type           = "gp3"
      delete_on_termination = true
      # encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  #instance_type = var.frontend_node_instance_type

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [module.eks.node_security_group_id]
  }

  # if you want to use a custom AMI
  # image_id      = var.ami_id

  # If you use a custom AMI, you need to supply via user-data, the bootstrap script as EKS DOESNT merge its managed user-data then
  # you can add more than the minimum code you see in the template, e.g. install SSM agent, see https://github.com/aws/containers-roadmap/issues/593#issuecomment-577181345
  #
  # (optionally you can use https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/cloudinit_config to render the script, example: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/997#issuecomment-705286151)

  # user_data = base64encode(
  #   data.template_file.launch_template_userdata.rendered,
  # )

  user_data = base64encode(templatefile(
    "userdata/init.tpl",
    {
      cluster_name              = module.eks.cluster_id
      bootstrap_extra_args      = "--container-runtime containerd --kubelet-extra-args '--max-pods=20'"
    }
  ))


  # Supplying custom tags to EKS instances is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-ec2-${var.environment_name}-ingress-node"
    }
  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC tho)
  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "${var.project_name}-ebs-${var.environment_name}-ingress-node"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      Name = "${var.project_name}-eni-${var.environment_name}-ingress-node"
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "EKS example"
  }

  lifecycle {
    create_before_destroy = true
  }
}
