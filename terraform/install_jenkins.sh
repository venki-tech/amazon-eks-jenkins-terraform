#!/bin/bash
logfile="/tmp/install_jenkins.log"
chmod 777 $logfile

echo "user running script is : `whoami`" > $logfile 
yum -y update

echo "Install Java JDK 8"
yum remove -y java
yum install -y java-1.8.0-openjdk

echo "Install Maven"
yum install -y maven 

echo "Install git"
yum install -y git

echo "Install Docker engine"
yum update -y
yum install docker -y
chkconfig docker on
service docker start

echo "Pull latest version of Jenkins docker image"
docker pull jenkins/jenkins:latest

echo "Create Jenkins user in docker group"
useradd -m -G docker jenkins 
mkdir -p /home/jenkins/docker_volume
chown jenkins:jenkins -R /home/jenkins/docker_volume 

echo "run docker"
#docker run --name jenkins -d  -v /home/jenkins/docker_volume:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:latest
docker run --name jenkins -d -p 8080:8080 -p 50000:50000 jenkins/jenkins:latest