PUTIME=$(ps -eo pcpu | awk 'NR>1' | awk '{tot=tot+$1} END {print tot}')
UP=$(echo `uptime` | awk '{ print $3 " " $4 }')
echo "
System Summary (collected `date`)

 - Server name               = `hostname`
 - Kernel                    = `uname -r`
 - Load                      = `cat /proc/loadavg`
 - Memory free (real)        = `free -m | head -n 2 | tail -n 1 | awk {'print $4'}` Mb
 - Memory free (cache)       = `free -m | head -n 3 | tail -n 1 | awk {'print $3'}` Mb
 - Swap in use               = `free -m | tail -n 1 | awk {'print $3'}` Mb
 - System Uptime             = `echo $UP`
 - Public IP                 = `dig +short myip.opendns.com @resolver1.opendns.com`
 - Disk Space Used           = `df -h / | awk '{ a = $4 } END { print a }'`
 - Disk Space Free           = `df -h / | awk '{ a = $3 } END { print a }'`

" > /etc/motd
