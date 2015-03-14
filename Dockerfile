FROM rlouapre/centos6-ml8:8.0-1.1
MAINTAINER Richard Louapre <richard.louapre@marklogic.com>

RUN yum update -y

ENV JAVA_VERSION 1.8.0
# Install JDK
RUN yum install -y java-${JAVA_VERSION}-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Install Git
RUN yum install -y git
# Install Unzip
# RUN yum install -y unzip

# installs to /opt/gradle
# $GRADLE_HOME points to latest *installed* (not released)
# ENV GRADLE_VERSION 2.3
# ENV GRADLE_ZIP_FILE gradle-${GRADLE_VERSION}-all.zip
# WORKDIR /tmp
# RUN curl -k -L -o ${GRADLE_ZIP_FILE} http://downloads.gradle.org/distributions/${GRADLE_ZIP_FILE}
# RUN unzip -q ${GRADLE_ZIP_FILE} -d /opt/gradle
# RUN ls /opt/gradle
# RUN ln -sfn /opt/gradle/gradle-${GRADLE_VERSION}/ /opt/gradle/latest
# RUN printf "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
# RUN chmod 777 /etc/profile.d/gradle.sh
# RUN /etc/profile.d/gradle.sh
# check installation
# RUN /opt/gradle/latest/bin/gradle -v
# RUN rm /tmp/${GRADLE_ZIP_FILE}

# RUN mkdir /opt/samplestack
WORKDIR /opt
RUN git clone https://github.com/marklogic/marklogic-samplestack

WORKDIR /
# Expose MarkLogic admin
EXPOSE 2022 8000 8001 8002
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 
