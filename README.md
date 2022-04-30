# repositoryName 
- repositoryName : {csp}-{accountName}

# terraform layout 전략 key 포인트
- 각 환경별(prod/dev/stg) 테라폼 소스를 어떻게 나눌 것인가?
- 나누어진 테라폼 소스를 어떻게 수월하게 배포할 것인가?

# layout 전략1
- sigle git repo 전략 : 환경을 폴더로 구분 하기

```
aws-lincoln
└── global
└── prod
    └── services
        ├── mgmt
        ├── network
        ├── was
        └── web
└── stg
    └── services
        ├── mgmt
        ├── network
        ├── was
        └── web
└── dev
    └── services
        ├── mgmt
        ├── network
        ├── was
        └── web
```
- 장점 : 
- 단점 : 

# layout 전략2
- sigle git repo + git branch 전략 : 하나의 git repo에 환경을 git branch로 나누는 전략

```
## prod branch
aws-lincoln
└── global
└── services
    ├── mgmt
    ├── network
    ├── was
    └── web

## dev branch
aws-lincoln
└── global
└── services
    ├── mgmt
    ├── network
    ├── was
    └── web
```
- 장점 : 
- 단점 : 


# layout 전략3
- sigle git repo + terraform workspace 전략 : 하나의 repo에 환경을 terraform workspace로 나누는 전략
```
aws-lincoln
└── global
└── services
    ├── mgmt
    ├── network
    ├── was
    └── web
```

# layout 전략4
- multi git repo 전략 : 환경별로 repo를 나누기

```
aws-lincoln-prod
└── global
└── services
    ├── mgmt
    ├── network
    ├── was
    └── web

aws-lincoln-dev
└── global
└── services
    ├── mgmt
    ├── network
    ├── was
    └── web
```



# resourceName Rule
- {environmentName}-{accountName}-{(optional)serviceGroupName}-{serviceName}-{(optional)resourceName}
- prod-lincoln-terraform-s3
