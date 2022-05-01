output "this_lincoln_vpc_info" {
	value = "${data.terraform_remote_state.lincoln_vpc_info}"
}

output "this_account_name" {
	value = "${var.account_name}"
}

output "this_env" {
	value = "${var.env}"
}

output "this_account_id" {
	value = "${var.account_id}"
}
