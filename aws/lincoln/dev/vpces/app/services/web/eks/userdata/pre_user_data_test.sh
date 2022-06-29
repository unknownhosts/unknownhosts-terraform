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


export LANG=C
export LC_ALL=C

CHMOD=`which chmod`

# 220220_Security_Setting ADD
# SRV_LINUX_091
suid_sgid_chmod() {
FILES="/sbin/unix_chkpwd /usr/bin/newgrp"
for file in $FILES
do
if [ -e $file ]
then
if [ `ls -l $file | awk '{print $1}' | grep -i 's' | wc -l` -ge "1" ]
then
"$CHMOD" -s $file
fi
fi
done
}

# 220220_Security_Setting ADD
# SRV_LINUX_109, 115 Log Setting
# TODO: rsyslog setting CentOS 7 Version ??

#syslog_kafka_install() {
#    yum install -y rsyslog-kafka
#}

pam_securetty_setting() {
cat >> /etc/pam.d/login <<- EOF
# 0328_security_pam_securetty
auth [user_unknown=ignore success=ok ignore=ignore default=bad] pam_securetty.so
EOF
}



# 220220_Security_Setting ADD
# SRV_LINUX_122 UMASK Setting
umask_setting() {
echo "umask 022" >> /etc/profile
echo "export umask" >> /etc/profile
}

# 220220_Security_Setting ADD
# SRV_LINUX_163 issue info Setting
issue_setting() {
FILES="/etc/issue /etc/issue.net /etc/motd"
for file in $FILES
do
cat > $file <<- EOF
===========================================================================
This is a private computer facility.
Access for any reason must be specifically authorized by the manager.
Unless you are so authorized, your continued access and any other use may
expose you to criminaland or civil proceedings
===========================================================================
EOF
done
}

init_yum_package() {
echo ">>> init_yum_package"
# date
rm /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Install package awslogs cli jq telnet
yum -y update
yum install -y awslogs jq aws-cli telnet wget util-linux-user
yum remove -y rpcbind
}

init_mkdir_log(){
if [ ! -d /var/log/k8s/logs ];
then
mkdir -p /var/log/k8s/logs
chmod -R 777 /var/log/k8s
ln -s /var/log/k8s/logs /home/deploy/logs
fi
}


init_security_inspection() {
echo ">>> init_security_inspection"
#### add /etc/sudoers
cat >> /etc/sudoers <<- EOF
seadmin ALL=NOPASSWD: ALL, !/bin/su, !/sbin/reboot, !/usr/bin/reboot, !/sbin/shutdown, !/sbin/halt, !/usr/bin/halt, !/sbin/poweroff, !/usr/bin/poweroff, !/sbin/init, !/usr/sbin/adduser, !/usr/sbin/useradd, !/usr/sbin/userdel, !/sbin/iptables, !/usr/bin/passwd
deploy  ALL=NOPASSWD: ALL, !/bin/su, !/sbin/reboot, !/usr/bin/reboot, !/sbin/shutdown, !/sbin/halt, !/usr/bin/halt, !/sbin/poweroff, !/usr/bin/poweroff, !/sbin/init, !/usr/sbin/adduser, !/usr/sbin/useradd, !/usr/sbin/userdel, !/sbin/iptables, !/usr/bin/passwd
EOF

#####################################
# KAKAO security check
#####################################

sudo chsh ec2-user -s /sbin/nologin
sudo systemctl restart sshd


SECURITY_FILE1="/etc/login.defs"
SECURITY_PATTERN1_OLD="PASS_MIN_LEN	5"
SECURITY_PATTERN1_NEW="PASS_MIN_LEN	12"
if sudo grep "$SECURITY_PATTERN1_OLD" $SECURITY_FILE1 > /dev/null
then
sudo sed -i "s/$SECURITY_PATTERN1_OLD/$SECURITY_PATTERN1_NEW/g" $SECURITY_FILE1
fi


SECURITY_PATTERN2_OLD="PASS_MIN_DAYS	0"
SECURITY_PATTERN2_NEW="PASS_MIN_DAYS	1"
if sudo grep "$SECURITY_PATTERN2_OLD" $SECURITY_FILE1 > /dev/null
then
sudo sed -i "s/$SECURITY_PATTERN2_OLD/$SECURITY_PATTERN2_NEW/g" $SECURITY_FILE1
fi


SECURITY_FILE3="/etc/mail/sendmail.cf"
if sudo grep "O SmtpGreetingMessage=\$j" $SECURITY_FILE3 > /dev/null
then
sudo sed -i "/O SmtpGreetingMessage=\$j/i\O SmtpGreetingMessage=Sendmail" $SECURITY_FILE3
sudo sed -i "/O SmtpGreetingMessage=\$j/d" $SECURITY_FILE3
fi

SECURITY_PATTERN4_OLD="O PrivacyOptions=authwarnings,novrfy,noexpn,restrictqrun"
SECURITY_PATTERN4_NEW="O PrivacyOptions=authwarnings,novrfy,noexpn,restrictqrun,restrictmailq"
if sudo grep "$SECURITY_PATTERN4_OLD" $SECURITY_FILE3 > /dev/null
then
sudo sed -i "s/$SECURITY_PATTERN4_OLD/$SECURITY_PATTERN4_NEW/g" $SECURITY_FILE3
fi
}


init_user() {
echo ">>> init_user"

# ec2-user gid change
sudo groupmod -g 500 ec2-user
sudo usermod -u 500 ec2-user

sudo groupadd -g 9998 crong
sudo adduser crong -g crong -u 9998
sudo groupadd -g 2015 dceng
sudo adduser dceng -g dceng -u 2015

# s3curity:x:9999:9999::/home/s3curity:/bin/bash
groupadd -g 9999 s3curity
adduser s3curity -g s3curity -u 9999

# itsec.red:x:20020:20020::/home/itsec.red:/bin/bash
groupadd -g 20020 itsec.red
adduser itsec.red -g itsec.red -u 20020

# deploy useradd
groupadd -g 1000 deploy
adduser deploy -g deploy -u 1000
## ec2-user groups add
sudo usermod -aG ec2-user,wheel,docker deploy
usermod -s /sbin/nologin docker

# deploy ssh
mkdir /home/deploy/.ssh


cat > /home/deploy/.ssh/authorized_keys <<- EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDiid2/EOlXtxwpViobNPMn9yphh63DqPee4ZkbvRmRnGQAQLwJtopz7s9C9i3jXJCT+kPBnr51u3utQmFfRSzgPHXRHLM/g1LlPHg8hfBPOLkF9yBdTcbCRxKPs3WzopEEWN4xdwVv5UgPuvxD3xxLaXLH0rymvHmRATV8SCIf8q+p8MOggmVXUxpvqRUqRobg1MZAk8J4TgJtOGjzeYYfIwL4BfveOu/3ZFyB2rLHK/0RTiIV48Mm6wrzCJT3ouSIa2vsk6Ggz/cHysagdF7PAxTu7qT8MYMMf/fUzTZmGSjjkTJj/mvLRoiuXnx4JjuzHWS2lrnnOqH0c57ZvxRDiNtDqZDizKICrezlmfA6RJubrAha5YvfLgbxANiVykAH4tqgGpCpHo8JZ/YfknOthACEy/ki0Vt636BzIhOQPnJ7JUeT0GWVoi0MqpS/Of6NGRUEs8tWIZBwSEaA3wM13MF0VFofq33hZcQi/9ycGs0obR8UBS9BNN+VXWFuR60yDoYnptEA8y/YTftLpUbP8c4NLM8gRnQUR8T0w7QgtqIY/3EJwCd0BA55xM9qysP6bSZ5do6STwQnterPr35XjDQ510h79czJ7OEy16gvoJ8PpAWYpCpPIrNm0XgJ8EH3yGllfYC2nz9EqDgjcd2982/s+QAB2g0S3bzXYWEujw== deploy@lincoln-keypair-dev
EOF
chown -R deploy:deploy /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chmod 600 /home/deploy/.ssh/authorized_keys

}


init_eks_config() {
# init kernel parameter
CONF_PATH="/etc/sysctl.conf"
KERNEL_PARA="net.ipv4.ip_unprivileged_port_start"
if sudo grep "$KERNEL_PARA" $CONF_PATH >> /dev/null
then
sudo sed -i "s/$KERNEL_PARA.*/$KERNEL_PARA=0/g" $CONF_PATH
else
echo "$KERNEL_PARA=0" | sudo tee -a $CONF_PATH
fi
sudo sysctl -p

## Flush iptables rules added by VPC CNI for Using Cilium
## https://docs.cilium.io/en/v1.11/gettingstarted/k8s-install-helm/
sudo iptables -t nat -F AWS-SNAT-CHAIN-0
sudo iptables -t nat -F AWS-SNAT-CHAIN-1
sudo iptables -t nat -F AWS-CONNMARK-CHAIN-0
sudo iptables -t nat -F AWS-CONNMARK-CHAIN-1
}

stop_postfix() {
#stop and disable mail service fo security
sudo systemctl stop postfix
sudo systemctl disable postfix
}


### Funtion Call
init_user

init_yum_package

init_security_inspection

#init_aws_host

#init_mkdir_log

#init_resolv

init_eks_config

stop_postfix

suid_sgid_chmod

#sec_userdel

umask_setting

issue_setting

pam_securetty_setting
