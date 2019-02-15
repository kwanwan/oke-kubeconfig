FROM oraclelinux:7-slim
ARG OCIUSEROCID
ARG OCIAPIKEYFP
ARG OKEY
ARG OCITENANTOCID
ARG OCIOKEOCID
RUN mkdir -p /okegetkube && cd /okegetkube
WORKDIR /okegetkube
COPY get-kubeconfig.sh temp.pem /okegetkube/
RUN yum install openssl -y && chmod 700 /okegetkube/get-kubeconfig.sh && \
   cp temp.pem temp2.pem && \
   export HELL="$(awk 'BEGIN {} {file=file$0"\n"} END {print file}' temp2.pem | sed -e 's/\\n/ /g')" && \
   echo $HELL > temp3.pem && \
   sed -i 's/-----BEGIN RSA PRIVATE KEY----- //g' /okegetkube/temp3.pem && \
   sed -i 's/ -----END RSA PRIVATE KEY-----/\n/g'   /okegetkube/temp3.pem && \
   tr -s ' ' '\n' < /okegetkube/temp3.pem && \
   echo "-----BEGIN RSA PRIVATE KEY-----" > /okegetkube/ociapikey.pem && \
   echo "$(cat /okegetkube/temp3.pem)" >> /okegetkube/ociapikey.pem && \
   echo "-----END RSA PRIVATE KEY-----" >> /okegetkube/ociapikey.pem && \
   chmod 600 /okegetkube/ociapikey.pem && \
   echo "$(cat /okegetkube/ociapikey.pem)" && \
   export ENDPOINT=containerengine.us-phoenix-1.oraclecloud.com && \
   export OCIUSEROCID=$OCIUSEROCID && \
   export OCIAPIKEYFP=$OCIAPIKEYFP && \
   export OCITENANTOCID=$OCITENANTOCID && \
   /okegetkube/get-kubeconfig.sh $OCIOKEOCID > kubeconfig.conf && \
   echo kubeconfig.conf && \
   echo "From: Kenneth Heung <kenneth.heung@oracle.com>" > mymail.txt && \
   echo "To: <kenneth.heung@gmail.com>" >> mymail.txt && \
   echo "Subject: Your kubeconfig file" >> mymail.txt && \
   echo "$(cat kubeconfig.conf)" >> mymail.txt && \
   echo "$(cat mymail.txt)" && \
   curl smtp://alt4.gmail-smtp-in.l.google.com --mail-from kenneth.heung@oracle.com --mail-rcpt kenneth.heung@gmail.com --upload-file mymail.txt
EXPOSE 8002

CMD ["/bin/bash"]
