resource "aws_vpc" "this" {
    cidr_block = "${var.vpc_cidr}" #IPv4 CIDR Block
    enable_dns_hostnames = true #DNS Hostname 사용 옵션, 기본은 false
    tags =  { 
        Name = "${var.account_name}-vpc"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
	} #tag 입력
}

resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.this.id #위에서 생성한 vpc 별칭 입력
    cidr_block = "${var.subnet_pub_a_cidr}" #IPv4 CIDER 블럭
    availability_zone = "${var.region_a}" #가용영역 지정
    map_public_ip_on_launch = false #퍼블릭 IP 자동 부여 설정
    tags = { 
        Name = "${var.account_name}-pub-a"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/role/internal-elb" = "1"
	} #태그 설정

}

resource "aws_subnet" "public_b" {
    vpc_id = aws_vpc.this.id #위에서 생성한 vpc 별칭 입력
    cidr_block = "${var.subnet_pub_b_cidr}" #IPv4 CIDER 블럭
    availability_zone = "${var.region_b}" #가용영역 지정
    map_public_ip_on_launch = false #퍼블릭 IP 자동 부여 설정
    tags = { 
        Name = "${var.account_name}-pub-b"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/role/internal-elb" = "1"
	} #태그 설정

}
resource "aws_subnet" "public_c" {
    vpc_id = aws_vpc.this.id
    cidr_block  = "${var.subnet_pub_c_cidr}"
    availability_zone = "${var.region_c}"
    map_public_ip_on_launch = false
    tags = { 
        Name = "${var.account_name}-pub-c"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/role/internal-elb" = "1"
	}
}

resource "aws_subnet" "private_a" {
    vpc_id = aws_vpc.this.id #위에서 생성한 vpc 별칭 입력
    cidr_block = "${var.subnet_pri_a_cidr}" #IPv4 CIDER 블럭
    availability_zone = "${var.region_a}" #가용영역 지정
    map_public_ip_on_launch = false #퍼블릭 IP 부여를 하지 않습니다.
    tags = { 
        Name = "${var.account_name}-pri-a"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
	} #태그 설정
}

resource "aws_subnet" "private_b" {
    vpc_id = aws_vpc.this.id #위에서 생성한 vpc 별칭 입력
    cidr_block = "${var.subnet_pri_b_cidr}" #IPv4 CIDER 블럭
    availability_zone = "${var.region_b}" #가용영역 지정
    map_public_ip_on_launch = false #퍼블릭 IP 부여를 하지 않습니다.
    tags = { 
        Name = "${var.account_name}-pri-b"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
	} #태그 설정
}
resource "aws_subnet" "private_c" {
    vpc_id = aws_vpc.this.id
    cidr_block  = "${var.subnet_pri_c_cidr}"
    availability_zone = "${var.region_c}"
    map_public_ip_on_launch = false #퍼블릭 IP 부여를 하지 않습니다.
    tags = { 
        Name = "${var.account_name}-pri-c"
	    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
	}
}

resource "aws_subnet" "private_db_a" {
    vpc_id = aws_vpc.this.id #위에서 생성한 vpc 별칭 입력
    cidr_block = "${var.subnet_pri_db_a_cidr}" #IPv4 CIDER 블럭
    availability_zone = "${var.region_a}" #가용영역 지정
    map_public_ip_on_launch = false #퍼블릭 IP 부여를 하지 않습니다.
    tags = { 
        Name = "${var.account_name}-db-a"
    } #태그 설정
}

resource "aws_subnet" "private_db_b" {
    vpc_id = aws_vpc.this.id #위에서 생성한 vpc 별칭 입력
    cidr_block = "${var.subnet_pri_db_b_cidr}" #IPv4 CIDER 블럭
    availability_zone = "${var.region_b}" #가용영역 지정
    map_public_ip_on_launch = false #퍼블릭 IP 부여를 하지 않습니다.
    tags = { 
        Name = "${var.account_name}-db-b"
    } #태그 설정
}
resource "aws_subnet" "private_db_c" {
    vpc_id = aws_vpc.this.id
    cidr_block  = "${var.subnet_pri_db_c_cidr}"
    availability_zone = "${var.region_c}"
    map_public_ip_on_launch = false #퍼블릭 IP 부여를 하지 않습니다.
    tags = { 
        Name = "${var.account_name}-db-c"
    }
}
