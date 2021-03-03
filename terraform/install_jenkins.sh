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


