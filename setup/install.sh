#!/bin/bash
# Usage
# sh ./install.sh <DB PASSWORD>
#
if [ $1 == "" ]; then
    echo "Please provide desired RDS Database Password"
    exit 1
fi

DB_PASSWORD=$1

# Perform a quick update on your instance:
sudo yum update -y

# Install git in your EC2 instance
sudo yum install git -y

# Check git version
git version

# Install Terraform in your EC2 instance
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

#check terraform version
terraform --version

# Clone Coforma acme-challenge repository
git clone https://github.com/coforma-acme/acme-tech-challenge.git

# Change directory to setup folder
cd acme-tech-challenge/setup

# Run terraform init
terraform init

# Run terraform plan
terraform plan -var "db_password=$DB_PASSWORD"

# Run terraform apply
terraform apply -var "db_password=$DB_PASSWORD"
