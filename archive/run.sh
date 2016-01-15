#!/bin/bash

CURRDATE=$(date +%Y-%m-%d_%H%M)

# Run playbooks
cd /git/ansible 

/usr/local/bin/ansible-playbook playbooks/automatic/repositories.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/packages_base.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/sudoers.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/dotfiles_minimal.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/server.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/ups_check.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/nagios_client.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/ntp_client.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/users_jay.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/users_jay_apps.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/workstation.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/packages_games.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/de_gnome.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/de_mate.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/wm_openbox.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/raspberry_pi.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/kvm_host.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/dm_gdm.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/dm_lightdm.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/openssh_p22.yml >> "/var/log/ansible/ansible-$CURRDATE.log"
/usr/local/bin/ansible-playbook playbooks/automatic/openssh_p65001.yml >> "/var/log/ansible/ansible-$CURRDATE.log"

find /var/log/ansible -type f -mtime +1 -delete

rm -r /home/ansible/.ansible/tmp
