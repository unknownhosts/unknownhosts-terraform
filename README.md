# EKS Test Environment

EKS Test를 위한 환경을 Terraform으로 구성하고, 이를 관리 쉽도록 하기 위한 Tool 들을 사용해본다.

**Considerations**

- 각 환경(test, dev, prod, ..)은 Terraform Workspace를 통해 관리한다.
  - dev, prod
- 리소스 간의 참조는 Remote State로 가져옴
- terragrunt를 사용하여 공통 설정 관리하며, Atlantis Server에서만 동적으로 생성
  - _backend.tf
  - _provider.tf
  - _shared_config.tf
    - 여러 Project에서 사용하는 공용 local, variables 관리
- AssumeRole을 사용하여 인증 수행 (Terraform은 Atlantis Server에서만 수행이 가능하도록 Trusted Entity를 설정하였다.)
  - 인증이 필요한 부분은 총 2가지 부분 : _backend.tf, _provider.tf
- NodeGroup은 추후 Golden AMI 부분을 고려하여 Launch Template으로 관리
- Tag 정책
  - Env
  - ..
