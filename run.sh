#!/bin/bash

CURRDATE=$(date +%Y-%m-%d_%H%M)

# Run playbooks
cd /git/ansible 

/usr/local/bin/ansible-playbook site.yml >> "/var/log/ansible/ansible-$CURRDATE.log"

find /var/log/ansible -type f -mtime +1 -delete

rm -r /home/ansible/.ansible
