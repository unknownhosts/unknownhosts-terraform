
module "ec2_atlantis"{
  source                 = "../../../../../../../modules/ec2"

  name                   = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-atlantis"
  instance_count         = 1

  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = var.ec2_atlantis_instnace_type
  
  key_name               = data.terraform_remote_state.keypair.outputs.key_pair
  monitoring             = true
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.atlantis_sg_id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.vpc[0].public_subnets[0]
  associate_public_ip_address = true 
  
  user_data = filebase64("userdata/atlantis_userdata.sh")
  
  enable_volume_tags = true
  
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]
  
  tags = merge(
        {
          Name = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-atlantis"
        },
        var.tags
        )
}

resource "aws_eip" "eip_atlantis" {
  instance = module.ec2_atlantis.id[0]
  vpc      = true
}