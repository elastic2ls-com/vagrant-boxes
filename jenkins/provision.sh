#!/bin/bash
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
apt-get update
sudo apt install openjdk-8-jre -y
sudo apt-get install jenkins -y
systemctl start jenkins.service
