#/usr/bin/bash

# Verify HiTrust Requirements

HOSTNAME=`hostname`

function verify(){
  if [ "$2" = "" ]
  then
    echo "$1: Not Installed"
  else
    echo "$1: Installed"
  fi
}

verify 'Antivirus' `dpkg --get-selections | grep clamav`
verify 'Login Banner' `grep -c "AT&T" /etc/motd | grep 5`

echo 'Time Sync:' `cat /etc/ntp.conf | grep server | awk '{print $2}' | paste -s --delimiters=","`
echo 'Public ports:' `netstat -lat | awk {'print $4'} | egrep "$HOSTNAME|\*" | sort | uniq | paste -s --delimiters=","`
echo 'Last Package Update: ' `ls -l /var/log/dpkg.log | awk '{print $6}'`
echo 'Pending Security Updates: ' `/usr/lib/update-notifier/apt-check 2>&1 | cut -d ';' -f 2`
