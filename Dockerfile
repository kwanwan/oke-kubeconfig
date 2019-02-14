FROM oraclelinux:7-slim
ARG OCIUSEROCID
ARG OCIAPIKEYFP
ARG OKEY
ARG OCITENANTOCID
ARG OCIOKEOCID
RUN mkdir -p /okegetkube && cd /okegetkube
WORKDIR /okegetkube
COPY get-kubeconfig.sh /okegetkube
RUN yum install openssl -y && chmod 700 /okegetkube/get-kubeconfig.sh && \
   echo $OKEY > /okegetkube/temp.pem && \
   sed -i 's/-----BEGIN RSA PRIVATE KEY----- //g' /okegetkube/temp.pem && \
   sed -i 's/ -----END RSA PRIVATE KEY-----/\n/g'   /okegetkube/temp.pem && \
   tr -s ' ' '\n' < /okegetkube/temp.pem && \
   echo "-----BEGIN RSA PRIVATE KEY-----" > /okegetkube/ociapikey.pem && \
   echo "$(cat /okegetkube/temp.pem)" >> /okegetkube/ociapikey.pem && \
   echo "-----END RSA PRIVATE KEY-----" >> /okegetkube/ociapikey.pem && \
   chmod 600 /okegetkube/ociapikey.pem && \
   echo "$(cat /okegetkube/ociapikey.pem)" && \
   echo $OCIUSEROCID && \
   echo && \
   export ENDPOINT=containerengine.us-phoenix-1.oraclecloud.com && \
   export OCIUSEROCID=$OCIUSEROCID && \
   export OCIAPIKEYFP=$OCIAPIKEYFP && \
   export OCITENANTOCID=$OCITENANTOCID && \
   /okegetkube/get-kubeconfig.sh $OCIOKEOCID
EXPOSE 8002

CMD ["/bin/bash"]
