MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -ex
/etc/eks/bootstrap.sh ${CLUSTER_NAME} \
  --container-runtime containerd

sudo yum -y install telnet
sudo yum -y install tcpdump

--==MYBOUNDARY==--