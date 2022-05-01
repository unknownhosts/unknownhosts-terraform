# 인터넷 게이트웨이 생성

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id #어느 VPC와 연결할 것인지 지정
    tags = { 
		Name = "${var.account_name}-igw"
	}  #태그 설정
}

# NAT 게이트웨이가 사용할 Elastic IP생성
resource "aws_eip" "nat_ip" {
	vpc = true  #생성 범위 지정
}

# NAT 게이트웨이 생성
resource "aws_nat_gateway" "this" {
	allocation_id = aws_eip.nat_ip.id #EIP 연결
	subnet_id     = aws_subnet.public_a.id #NAT가 사용될 서브넷 지정
	tags = {
		Name = "${var.account_name}-ngw"
	}
}
