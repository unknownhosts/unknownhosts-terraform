# EKS Test Environment

EKS Test를 위한 환경을 Terraform으로 구성하고, 이를 관리 쉽도록 하기 위한 Tool 들을 사용해본다.

**Considerations**

- 각 환경(test, dev, prod, ..)은 Terraform Workspace를 통해 관리한다.
- 리소스 간의 참조는 Remote State로 가져옴
  - 각 Project 간 의존성이 있을 경우 terragrunt.hcl 파일 내에 dependency를 명시적으로 기록해준다. 
- terragrunt를 사용하여 공통 설정 관리하며, Atlantis Server에서만 동적으로 생성
  - _backend.tf
  - _provider.tf
  - _shared_config.tf
    - 여러 Project에서 사용하는 공용 local, variables 관리
- AssumeRole을 사용하여 인증 수행 (Terraform은 Atlantis Server에서만 수행이 가능하도록 Trusted Entity를 설정하였다.)
  - 인증이 필요한 부분 : _backend.tf, _provider.tf
- Tag 정책
  - Env