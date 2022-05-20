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
### terraform source code rule
- all code : small letter
- terraform resources : snake case
- terraform variables : snake case
- terraform outputs : snake case
- aws resources : kebab case


## AWS rules
### AWS naming rule
```
{project_name}-{phase}-{resource_name}-{service_group_name}-{service_name}
ex) lincoln-dev-mgmt-atlantis-ec2

{project_name}-{phase}-{resource_name}-{etc}
ex) lincoln-dev-terraform-state-ddb
```

