#!/bin/bash

CURRDATE=$(date +%Y-%m-%d_%H%M)
ANSIBLE=$(which ansible-playbook)

# Run playbooks
cd /var/ansible

git pull

$ANSIBLE site.yml >> "/var/log/ansible/ansible-$CURRDATE.log"

find /var/log/ansible -type f -mmin +360 -delete

rm -r /home/ansible/.ansible
