output "this_vpc_id" {
	value = "${aws_vpc.this.id}"
}

output "this_pub_sbnt_a_id" {
	value = "${aws_subnet.public_a.id}"
}

output "this_pub_sbnt_b_id" {
	value = "${aws_subnet.public_b.id}"
}

output "this_pub_sbnt_c_id" {
	value = "${aws_subnet.public_c.id}"
}

output "this_pri_sbnt_a_id" {
	value = "${aws_subnet.private_a.id}"
}

output "this_pri_sbnt_b_id" {
	value = "${aws_subnet.private_b.id}"
}

output "this_pri_sbnt_c_id" {
	value = "${aws_subnet.private_c.id}"
}

output "this_db_sbnt_a_id" {
	value = "${aws_subnet.private_db_a.id}"
}

output "this_db_sbnt_b_id" {
	value = "${aws_subnet.private_db_b.id}"
}

output "this_db_sbnt_c_id" {
	value = "${aws_subnet.private_db_c.id}"
}
