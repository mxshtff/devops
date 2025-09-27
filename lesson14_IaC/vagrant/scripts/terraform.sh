#!/bin/bash

# terraform install
TERRAFORM_VERSION=1.9.8
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/terraform
rm -f LICENSE.txt


# yc install
sudo -u vagrant bash -c 'curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash'
