resource "aws_eip" "bastion" {
    instance = aws_instance.bastion.id
    vpc = true
    
    tags = {
        Name = "${module.global_variables.this_account_name}-bastion-eip"
    }
}
