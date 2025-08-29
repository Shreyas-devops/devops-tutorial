#!/bin/bash
sudo yum update -y
echo 'Installing docker on $(hostname)'
sudo yum install docker -y
if [ $? -eq 0 ]; then
echo 'Docker is installed ..'
sudo usermod -aG docker ec2-user
sudo systemctl start docker
sudo systemctl enable docker
sudo service docker status
echo 'docker version is '
sudo docker -v
echo 'Running Docker hello-world'
docker  run 'hello-world'
echo 'Installing Docker-compose...'
sudo curl -L "https://github.com/docker/compose/releases/download/v2.39.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo 'Docker Compose Installed.'
docker-compose --version
echo 'installing minikube '
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
echo 'starting minikube'
minikube start
echo '=================================================================================='
else
echo 'Docker installation failed on $(hostname)'
echo '=================================================================================='
fi
