FROM centos6-ml
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
WORKDIR /home
RUN git clone https://github.com/marklogic/marklogic-samplestack

# RUN /etc/rc.d/init.d/MarkLogic start && sleep 5
# RUN ifconfig
# RUN curl 127.0.0.1:8001 -v

WORKDIR /home/marklogic-samplestack/appserver/java-spring 
RUN ./gradlew seedDataFetch && ./gradlew seedDataExtract

WORKDIR /
# Expose MarkLogic admin
EXPOSE 8000 8001 8002 8006 8090
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 
