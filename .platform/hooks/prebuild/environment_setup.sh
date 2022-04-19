#!/bin/sh

sudo amazon-linux-extras enable postgresql11
sudo yum install -y postgresql-devel patch git

#Node.js/yarn install
cd /tmp
sudo curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum -y install nodejs
sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
sudo yum -y install yarn

#Fix for an issue with Nokogiri and GLIBC errors on AWS graviton
bundle config set force_ruby_platform true

