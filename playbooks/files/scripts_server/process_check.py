#!/usr/bin/python3

import logging
import os
import subprocess
import sys

svc = str(sys.argv[1])

logging.basicConfig(filename='/var/log/{0}-check.log'.format(svc),
                    format = '%(asctime)s - %(levelname)s: %(message)s',
                    level=logging.DEBUG)

logging.info('Checking if process ' + svc + ' is running')

service_is_running = subprocess.call(["ps", "-C", svc])

if service_is_running == 1:
    logging.warning('Process ' + svc + ' is not running')
    logging.info('Attempting to restart: ' +svc)

    if os.path.exists('/usr/sbin/service'|'/sbin/service'):
        start_cmd = subprocess.call(["sudo", "/etc/init.d/%s" % svc, "start"])
    if os.path.exists('/bin/systemctl'|'/usr/sbin/systemctl'):
        start_cmd = subprocess.call(["sudo", "systemctl", "start", "%s" % svc])

    if start_cmd == 1:
        logging.error("Unable to restart %s. Please check the logs." % svc)
    else:
        logging.info("%s successfully restarted" % svc)

else:
    logging.info("%s is currently running" % svc)
