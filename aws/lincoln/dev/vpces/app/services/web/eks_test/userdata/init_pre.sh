#!/bin/bash
### EKS Optimized AMI를 사용할때 bootstrap.sh 파라미터 넣기
set -ex
cat <<-EOF > /etc/profile.d/bootstrap.sh
export CONTAINER_RUNTIME="containerd"
export USE_MAX_PODS=false
export KUBELET_EXTRA_ARGS="--max-pods=110"
EOF
# Source extra environment variables in bootstrap script
sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh


### OS에 필요한 작업들 아래부터 넣기
echo "Running custom user data pre script"
