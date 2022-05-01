resource "aws_instance" "was" {
    ami = "ami-09ce2fc392a4c0fbc"
    instance_type = "t2.micro"
    subnet_id = "${module.global_variables.this_lincoln_vpc_info.outputs.this_pri_sbnt_a_id}"
    vpc_security_group_ids = [ 
        aws_security_group.was.id,
    ]
    user_data = <<EOF
#!/bin/bash

EOF
    iam_instance_profile = "${module.global_variables.this_account_name}-was-iam-profile"

    key_name = "${module.global_variables.this_account_name}-was"
    tags = {
        Name = "${module.global_variables.this_account_name}-was"
    }
    
    root_block_device {
        volume_size = 50
        volume_type = "gp2"
    }

}