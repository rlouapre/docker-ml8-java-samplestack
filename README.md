# docker-ml8-java-samplestack
Dockerfile for MarkLogic 8 and SampleStack Java

## Setup
Build docker image:  
```docker build --rm=true -t "rlouapre/centos6-ml8-java-samplestack" github.com/rlouapre/docker-ml8-java-va-samplestack
samplestack```  
Run docker named container:  
```docker run --name java-samplestack -d -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8006:8006 -p 8090:8090 rlouapre/centos6-ml8-java-samplestack```  
Bootstrap and start Samplestack:  
```docker exec java-samplestack bash -c "cd /home/marklogic-samplestack/appserver/java-spring && ./gradlew dbInit && ./gradlew appserver"```  

## Test

Samplestack web app accessible from: http://{docker-ip}:8090  
Samplestack REST server accessible from: http://{docker-ip}:8006  

If you are using docker-machine ip address is available from ```docker-machine ip {machine-name}```
