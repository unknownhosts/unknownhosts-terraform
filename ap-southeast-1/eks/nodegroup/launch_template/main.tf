// EKS NodeGroup Launch Template
resource "aws_launch_template" "this" {
  name = "${local.name_prefix}-nodegroup"

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings

    content {
      device_name = block_device_mappings.value.device_name

      ebs {

        delete_on_termination = lookup(block_device_mappings.value, "delete_on_termination", null)
        encrypted             = lookup(block_device_mappings.value, "encrypted", null)
        iops                  = lookup(block_device_mappings.value, "iops", null)
        kms_key_id            = lookup(block_device_mappings.value, "kms_key_id", null)
        snapshot_id           = lookup(block_device_mappings.value, "snapshot_id", null)
        throughput            = lookup(block_device_mappings.value, "throughput", null)
        volume_size           = lookup(block_device_mappings.value, "volume_size", null)
        volume_type           = lookup(block_device_mappings.value, "volume_type", null)
      }
    }
  }


  # https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html
  # 1.21 (Singapore) : ami-02a40e53af57ab26b
  image_id = local.launch_template.image_id

  instance_type          = local.launch_template.instance_type
  key_name               = local.launch_template.key_name
  vpc_security_group_ids = local.launch_template.sg_ids

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.tags,
      {
        Name = "${local.name_prefix}-nodegroup"
      }
    )
  }

  user_data = base64encode(data.template_file.userdata.rendered)
}

// EKS Node Group
resource "aws_eks_node_group" "this" {
  cluster_name = local.cluster_name

  node_group_name = "${local.name_prefix}-nodegroup"
  node_role_arn   = aws_iam_role.nodegroup.arn
  subnet_ids      = local.private_subnet_ids

  labels = merge(
    {
      Environment = local.env
    }
  )

  scaling_config {
    min_size     = local.nodegroup.min_size
    max_size     = local.nodegroup.max_size
    desired_size = local.nodegroup.desired_size
  }

  launch_template {
    id      = aws_launch_template.this.id
    version = local.nodegroup.lt_version
  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name_prefix}-nodegroup"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.nodegroup["AmazonEKSWorkerNodePolicy"],
    aws_iam_role_policy_attachment.nodegroup["AmazonEKS_CNI_Policy"],
    aws_iam_role_policy_attachment.nodegroup["AmazonEC2ContainerRegistryReadOnly"],
    aws_launch_template.this
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }
}