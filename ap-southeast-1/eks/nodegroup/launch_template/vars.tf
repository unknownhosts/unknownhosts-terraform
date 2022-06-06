# Launch Template
variable "launch_template_image_id" {}
variable "launch_template_instance_type" {}
variable "launch_template_key_name" {}
variable "block_device_mappings" {
  type        = list(any)
  description = <<-EOT
    List of block device mappings for the launch template.
    Each list element is an object with a `device_name` key and
    any keys supported by the `ebs` block of `launch_template`.
    EOT
  # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template#ebs
  default = [{
    device_name           = "/dev/xvda"
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }]
}


# Node Group
variable "lodegroup_desired_size" {}
variable "lodegroup_min_size" {}
variable "lodegroup_max_size" {}
variable "nodegroup_lt_version" {}