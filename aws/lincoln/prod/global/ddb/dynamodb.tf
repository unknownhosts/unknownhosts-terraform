
resource "aws_dynamodb_table" "lincoln-terraform-state-lock" {
  for_each = var.resource_name   
  name = "${terraform.workspace}-${local.common_tags.project_name}-terraform-state-lock-${each.value}"
  read_capacity = 5     
  write_capacity = 5 
  hash_key = "LockID" 

  attribute {
    name = "LockID"
    type = "S"  
  } 

   tags = merge(local.common_tags,
       {
            name = "${terraform.workspace}-${local.common_tags.project_name}-terraform-state-lock-${each.value}"
            createdBy = "jordan.kim"
       })       
}