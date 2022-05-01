
# public routing

resource "aws_route_table" "public" {
	vpc_id = aws_vpc.this.id #VPC 별칭 입력
  	tags = { 
		Name = "${var.account_name}-pub-rt" 
	} #태그 설정
  	route {
  		cidr_block = "0.0.0.0/0"
  		gateway_id = "${aws_internet_gateway.this.id}"
  	}
}

# private routing
resource "aws_route_table" "private" {
	vpc_id = aws_vpc.this.id #VPC 별칭 입력
	tags = { 
		Name = "${var.account_name}-pri-rt"
	} #태그 설정
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_nat_gateway.this.id}" #NAT Gateway 별칭 입력
	}

}
