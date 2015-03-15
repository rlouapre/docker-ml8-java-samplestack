# docker-ml8-java-samplestack
Dockerfile for MarkLogic 8 and SampleStack Java

## Setup
Build docker image:  
```docker build --rm=true -t "rlouapre/centos6-ml8-java-samplestack" github.com/rlouapre/docker-ml8-java-va-samplestack
samplestack```  

### Run Samplestack within the container (for demo)  
Run docker with named container:  
```docker run --name java-samplestack -d -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8006:8006 -p 8090:8090 rlouapre/centos6-ml8-java-samplestack```  
Bootstrap and start Samplestack:  
```docker exec java-samplestack bash -c "cd /home/marklogic-samplestack/appserver/java-spring && ./gradlew dbInit && ./gradlew appserver"```  

### Run Samplestack from a volume mounted to the container (for development)  
Assuming path-to-samplestack is /Users/Richard/Projects/ML/marklogic-samplestack  
```docker run --name java-samplestack -d -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8006:8006 -p 8090:8090 -v /Users/Richard/Projects/ML/marklogic-samplestack:/opt/marklogic-samplestack rlouapre/centos6-ml8-java-samplestack```  

```docker exec java-samplestack bash -c "cd /opt/marklogic-samplestack/appserver/java-spring && ./gradlew dbInit && ./gradlew appserver"```  

FIX: Windows / Virtualbox driver does not mount to local file system  
```VBoxManage controlvm ${machine-name} acpipowerbutton```  
```VBoxManage sharedfolder add ${machine-name} --name Users --hostpath c:/Users --automount```  
```VBoxManage startvm ${machine-name} --type headless```  

## Test

Samplestack web app accessible from: ```http://{docker-ip}:8090```  
Samplestack REST server accessible from: ```http://{docker-ip}:8006```  

If you are using docker-machine ip address is available from ```docker-machine ip {machine-name}```
