#!/bin/bash
        set -x
        yum update -y
        sudo yum install -y docker
        sudo yum install -y git
        sudo service docker start
        sudo usermod -a -G docker ec2-user
        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 020046395185.dkr.ecr.us-east-1.amazonaws.com
        docker run --name jenkins -d -v /var/run/docker.sock:/var/run/docker.sock -p 80:8080  020046395185.dkr.ecr.us-east-1.amazonaws.com/jenkins:latest

