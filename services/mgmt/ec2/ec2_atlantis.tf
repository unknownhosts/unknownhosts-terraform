
module "ec2_atlantis"{
  source                 = "../../../modules/ec2"

  name                   = "${terraform.workspace}-${var.project_name}-atlantis"
  instance_count         = 1

  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = var.ec2_atlantis_instnace_type
  
  key_name               = data.terraform_remote_state.keypair.outputs.lincoln_key_pair_key_name
  monitoring             = true
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.atlantis_sg_id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_id[0]
  associate_public_ip_address = true 
  
  #user_data_base64 = base64encode(local.user_data)
  
  enable_volume_tags = true
  
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
      tags = {
        Name = format("${var.project_name}-atlantis-root-ebs")
      }
    },
  ]
  
  tags = merge(local.common_tags, 
        {
          Name = "${terraform.workspace}-${var.project_name}-atlantis"
          createdBy = "jordan.kim"
        })
}