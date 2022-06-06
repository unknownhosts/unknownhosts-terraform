# Docker 배포

Reference <br>

Terragrunt : https://terragrunt.gruntwork.io/docs/getting-started/install/#download-from-releases-page <br>
Atlantis : https://www.runatlantis.io/docs/deployment.html#deployment-2

### 1. Docker Build
```bash
docker build -t atlantis_with_terragrunt:1 . --build-arg TERRAGRUNT=latest
```

### 2. Docker run with custom atlantis image
```bash
docker run -p 4141:4141 -v "/$(pwd)/repo.yaml:/home/atlantis/repo.yaml" \
-d atlantis_with_terragrunt:1 server \
--gh-user=<USERNAME> \
--gh-token=<GIT_TOKEN> \
--repo-allowlist=* \
--repo-config="/home/atlantis/repo.yaml"
```