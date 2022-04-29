# nyyangs

```

1. module 단위 / infra 단위
2. 리전 단위
3. 환경 단위
4. 리소스 단위
5. 서비스 단위

## Example

1. infra / modules
2. infra : apne2, common, variables
    => apne2, apne1, .. 리전별로 분리 / common : global resource / variables : 공용 변수
3. apne2 : dev, prod, common
    => dev, prod / common : 리전 내에서 공용으로 사용될 리소스
4. dev : ecs, elasticache, elb, vpc, ..
    => 리소스 단위
5. ecs : cluster, fargate_service, common
    => 리소스 내 리소스 단위
6. fargate_service : management, notification, gateway
    => 서비스 내 특정 기능 및 앱 단위
7. 특정 기능 및 앱 단위
    => 한꺼번에 배포 및 삭제되어도 다른 리소스에 영향도 최소화


## Example

├── infra
│   ├── apne2
│   │   ├── dev
│   │   │   ├── ecs
│   │   │   │   ├── cluster
│   │   │   │   ├── common
│   │   │   │   └── fargate_service
│   │   │   │       ├── gateway
│   │   │   │       ├── management
│   │   │   │       └── notification
│   │   │   ├── elasticache
│   │   │   ├── elb
│   │   │   │   └── internal
│   │   │   └── vpc
│   │   └── prod
│   │       ├── ec2
│   │       │   └── bastion
│   │       ├── ecs
│   │       │   ├── cluster
│   │       │   ├── common
│   │       │   └── fargate_service
│   │       │       ├── gateway
│   │       │       ├── management
│   │       │       └── notification
│   │       ├── elasticache
│   │       ├── elasticsearch
│   │       ├── elb
│   │       │   └── internal
│   │       └── vpc
│   ├── common
│   │   ├── backend
│   │   ├── ecs_iam
│   │   ├── network
│   │   │   └── vpc_peering
│   │   └── route53_acm
│   └── variables
├── modules
│   ├── ec2
│   └── vpc
```
