#!/bin/bash
set -e;

# --> Normally Vagrant installs ansible automatically
# Manual installation script because of problems with apt-add-repository --yes --update ppa:ansible/ansible

# --> You can install Ansible via the apt package manager (Workaround solution)
# apt update
# apt install software-properties-common -y
# echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" >> /etc/apt/sources.list.d/ansible.list
# echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" >> /etc/apt/sources.list.d/ansible.list
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367 
# apt update
# apt install ansible -y

# --> You can install Ansible via pip (Python)
# Only start installation, if ansible command is not available
if ! [[ $(command -v ansible) ]]; then
    apt update
    apt install python python-pip -y
    pip install ansible

    # Smoke test
    ansible --version
fi
