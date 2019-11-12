#!/usr/bin/env bash
sudo apt-get -y update

# Check if there is already Docker installed
# Create Docker Environment if not
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
if [ ! -f docker --version ]; then
    echo "Install packages to allow apt to use a repository over HTTPS"
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    echo "Add Docker’s official GPG key"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo "Verify that you now have the key with the fingerprint"
    sudo apt-key fingerprint 0EBFCD88 | grep "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
    echo "Update the apt package index."
    sudo apt-get update
    echo "Install the latest version of Docker CE"
    sudo apt-get -y install docker-ce
    echo 'Verify that Docker CE is installed correctly by running the hello-world image.'
    sudo docker run hello-world
fi



jupyter notebook --generate-config


# Create Hadoop Cluster using Docker

# Create Kibana Docker
docker pull docker.elastic.co/kibana/kibana:6.4.2
# kibana.yml
# https://www.elastic.co/guide/en/kibana/current/docker.html