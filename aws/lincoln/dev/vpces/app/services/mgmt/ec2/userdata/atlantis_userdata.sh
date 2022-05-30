#cloud-config

runcmd:
 - yum -y update
 - yum -y install docker 
 - service docker start