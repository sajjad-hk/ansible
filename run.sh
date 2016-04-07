#!/bin/bash

CURRDATE=$(date +%Y-%m-%d_%H%M)

# Run playbooks
cd /var/ansible

git pull

/usr/local/bin/ansible-playbook site.yml >> "/var/log/ansible/ansible-$CURRDATE.log"

find /var/log/ansible -type f -mmin +360 -delete

rm -r /home/ansible/.ansible
