FROM rlouapre/centos6-ml8:8.0-1.1
MAINTAINER Richard Louapre <richard.louapre@marklogic.com>

RUN yum update -y

ENV JAVA_VERSION 1.8.0
# Install JDK
RUN yum install -y java-${JAVA_VERSION}-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
RUN touch /etc/profile.d/java.sh && \
    echo '#!/bin/bash' >> /etc/profile.d/java.sh && \
    echo 'JAVA_HOME=/usr/lib/jvm/java-openjdk/' >> /etc/profile.d/java.sh && \
    echo 'PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh && \
    echo 'export PATH JAVA_HOME' >> /etc/profile.d/java.sh && \
    chmod +x /etc/profile.d/java.sh && \
    source /etc/profile.d/java.sh

# Install Git
RUN yum install -y git

# RUN mkdir /opt/samplestack
WORKDIR /opt
RUN git clone https://github.com/marklogic/marklogic-samplestack

WORKDIR /
# Expose MarkLogic admin
EXPOSE 2022 8000 8001 8002
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 
