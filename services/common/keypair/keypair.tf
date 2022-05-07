
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits = 4096
  
  provisioner "local-exec" {
    command = "echo '${tls_private_key.this.private_key_pem}' > ./${terraform.workspace}-${var.project_name}-keypair.pem"
  }
  
}

module "key_pair" {
  source = "../../../modules/keypair"

  key_name   = "${terraform.workspace}-${var.project_name}-keypair"
  public_key = tls_private_key.this.public_key_openssh
}