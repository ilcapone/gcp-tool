FROM debian:buster-slim
WORKDIR /sec
RUN mkdir SAs
RUN apt-get update -qqy && apt-get install -qqy curl gcc python3-dev python3-pip apt-transport-https lsb-release openssh-client git gnupg nano inetutils-ping
RUN git clone https://gitlab.com/gitlab-com/gl-security/security-operations/gl-redteam/gcp_enum
RUN git clone https://github.com/RhinoSecurityLabs/GCPBucketBrute.git && pip3 install -r GCPBucketBrute/requirements.txt
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
RUN apt-get install kubectl
RUN git clone https://github.com/aquasecurity/kube-hunter.git && cd kube-hunter && pip3 install -r requirements.txt && cd ../
RUN git clone https://github.com/cyberark/kubernetes-rbac-audit.git
ENTRYPOINT [ "/bin/bash" ]
      
