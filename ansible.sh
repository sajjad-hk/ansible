#!/bin/bash

source /usr/local/bin/.email-params
BODY="Ansible results are attached."
CURRDATE=$(date +%Y-%m-%d_%H%M)
ATTACHMENT="/var/log/ansible/ansible-$CURRDATE.log"

if [ -f /etc/apt/sources.list ]
then
    ANSIBLE="/usr/local/bin/ansible-playbook"
else
    ANSIBLE="/usr/bin/ansible-playbook"
fi

if [ -f /tmp/ansible.lock ]
then
    echo "Ansible may already be running, a lock file was found." > /var/log/ansible-$CURRDATE.log
    echo "Exiting." > /var/log/ansible/ansible-$CURRDATE.log
    RESULT="Skipped!"
    exit 1
fi

if [ ! -f /tmp/ansible.lock ]
then
    touch /tmp/ansible.lock

    cd /var/ansible; git pull
    $ANSIBLE site.yml >> "/var/log/ansible/ansible-$CURRDATE.log"

    if [ $? -eq 0 ]
    then
        RESULT="Successful!"
    else
        RESULT="FAILED!"
    fi

    find /var/log/ansible -type f -mmin +360 -delete

    rm /tmp/ansible.lock
    rm -r /home/ansible/.ansible
fi

# Set the subject line, with the $RESULT value.
SUBJECT="$HOSTNAME Ansible run: $RESULT"

# Send the email notification
/bin/echo $BODY | /usr/bin/mailx -r $SMTPFROM -s "$SUBJECT" -a $ATTACHMENT -S smtp="$SMTPSERVER" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="$SMTPUSER" -S smtp-auth-password="$SMTPPASS" -S ssl-verify=ignore $SMTPTO
