// Shared Variables
region  = "ap-southeast-1"
account = "sandbox"
tags    = {}

// Private Variables
// Launch Template
launch_template_image_id = "ami-02a40e53af57ab26b"
launch_template_instance_type = "t3.medium"
launch_template_key_name = "taehunKey"

// Node Group
lodegroup_desired_size = 2
lodegroup_min_size = 2
lodegroup_max_size = 4
nodegroup_lt_version = 1 # $Latest