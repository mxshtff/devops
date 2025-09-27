#!/bin/bash

ANSIBLE_USER=ansible
ANSIBLE_USER_HOME=/home/$ANSIBLE_USER
HOSTS=( haproxy-1 haproxy-2 postgres-1 postgres-2 )

# add ssh-key
if [ $HOSTNAME == 'ansible' ]; then
    mkdir -p /home/vagrant/.ssh/
    cp /vagrant/keys/ansible_id_rsa /home/vagrant/.ssh/
    chown vagrant:vagrant /home/vagrant/.ssh/ansible_id_rsa
    chmod 400 /home/vagrant/.ssh/ansible_id_rsa
fi


if [[ ${HOSTS[@]} =~ $HOSTNAME ]]; then
    # create ansible user
    adduser ansible
    usermod -aG wheel $ANSIBLE_USER
    echo "%$ANSIBLE_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$ANSIBLE_USER
    mkdir -p $ANSIBLE_USER_HOME/.ssh/
    cat /vagrant/keys/ansible_id_rsa.pub >> /home/ansible/.ssh/authorized_keys
fi
