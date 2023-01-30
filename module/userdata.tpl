MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -ex

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent

/etc/eks/bootstrap.sh '${cluster_name}' --b64-cluster-ca '${cluster_ca_base64}' --apiserver-endpoint '${api_server_url}'

--==MYBOUNDARY==--\


