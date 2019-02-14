FROM oraclelinux:7-slim
ARG OCIUSEROCID
ARG OCIAPIKEYFP
ARG OKEY
ARG OCITENANTOCID
ARG OCIOKEOCID
RUN mkdir -p /okegetkube && cd /okegetkube
WORKDIR /okegetkube
COPY get-kubeconfig.sh temp.pem /okegetkube
RUN yum install openssl -y && chmod 700 /okegetkube/get-kubeconfig.sh && \
   cp /okegetkube/temp.pem /okegetkube/ociapikey.pem && \
   chmod 600 /okegetkube/ociapikey.pem && \
   echo "$(cat /okegetkube/ociapikey.pem)" && \
   export ENDPOINT=containerengine.us-phoenix-1.oraclecloud.com && \
   export OCIUSEROCID=$OCIUSEROCID && \
   export OCIAPIKEYFP=$OCIAPIKEYFP && \
   export OCITENANTOCID=$OCITENANTOCID && \
   /okegetkube/get-kubeconfig.sh $OCIOKEOCID
EXPOSE 8002

CMD ["/bin/bash"]
