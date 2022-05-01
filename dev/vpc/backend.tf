terraform {
	backend "s3" {
		bucket = "dev-lincoln-tf-state"  #해당 부분에는 변수 사용 불가
		key = "vpc.tfstate"
		region = "ap-northeast-2"
		encrypt = true
	}
}
