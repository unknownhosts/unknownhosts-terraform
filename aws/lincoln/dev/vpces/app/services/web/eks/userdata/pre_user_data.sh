### eks bootstap custom setting
set -ex
cat <<-EOF > /etc/profile.d/bootstrap.sh
export CONTAINER_RUNTIME="containerd"
export USE_MAX_PODS=false
export KUBELET_EXTRA_ARGS="--max-pods=110"
EOF
# Source extra environment variables in bootstrap script
sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh

#### custom user date script 
echo "Running custom user data pre script"