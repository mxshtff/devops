#!/bin/bash

function repoAdapt() {
    sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
    sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
    sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
    bash -c 'echo "sslverify=false" >> /etc/yum.conf'
}

if [ $HOSTNAME != 'ansible' ]; then
    # selinux disable
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0

    # enable sshd PasswordAuthentication
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    systemctl restart sshd

    repoAdapt
    
    # add PG repo
    yum install -y centos-release-scl

    repoAdapt
fi
