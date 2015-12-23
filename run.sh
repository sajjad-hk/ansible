#!/bin/bash

cd /git/ansible && /usr/local/bin/ansible-playbook playbooks/automatic/_site.yml > "/var/log/ansible/ansible-$(date +%Y-%m-%d_%H%M).log"

find /var/log/ansible -type f -mtime +1 -delete

rm -r /home/ansible/.ansible/tmp
