# UKNOWNHOSTS (2022 Q2 lincoln project)

## git rules
### feature branch rules
```
feature_{name}_{yyyymmdd}_{detailes}
```

### git commit rules
```
git commit -m '{name}_{date}_{count}_{details}'
```


## terraform rules
### terraform layout rule
```
├── {csp}
│   ├── {project_name}
│   │   ├── {environment}
│   │   │   ├── global
│   │   │   │   ├── {resource_name}
│   │   │   └── vpcs
│   │   │       └── {vpc_name}
│   │   │           ├── services
│   │   │           │   └── {service_name}
│   │   │           │       └── {resource_name}
│   │   │           └── network
│   │   │               └── {resource_name}
│   ├── modules
│   │   └── {moudule_name}
```

## AWS rules
### AWS naming rule
```
{project_name}-{phase}-{service_group_name}-{service_name}-{resource_name}
ex) lincoln-dev-mgmt-atlantis-ec2
```

