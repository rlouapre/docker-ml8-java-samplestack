FROM rlouapre/centos6-ml8:8.0-1.1
MAINTAINER Richard Louapre <richard.louapre@marklogic.com>

RUN yum update -y
# Install JDK 1.7
RUN yum install -y java-1.7.0-openjdk.x86_64
# Install Git
RUN yum install -y git

# installs to /opt/gradle
# $GRADLE_HOME points to latest *installed* (not released)
ENV gradle_version 2.3
WORKDIR /tmp
RUN curl -k -L -O http://downloads.gradle.org/distributions/${gradle_version}-all.zip
RUN unzip -foq gradle-${gradle_version}-all.zip -d /opt/gradle
RUN ln -sfn gradle-${gradle_version} /opt/gradle/latest
RUN printf "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
RUN /etc/profile.d/gradle.sh
# check installation
RUN gradle -v
RUN rm /tmp/gradle-${gradle_version}-all.zip
WORKDIR /
# Expose MarkLogic admin
EXPOSE 2022 8000 8001 8002
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 
