#!/bin/bash

# Verify HiTrust Requirements


function print_usage {
  echo
echo "Usage: ${0} [site name] <netcat remote IP]>"
  echo
echo "Leaving netcat IP blank will give human readable output."
}

if [ -z ${1} ]
then
echo "Need site name (i.e. SAN, DFW, EWR, etc)."
  print_usage
  exit 1
fi

SITE=${1}
HOST=`hostname -f`
ADMIN_NAME=""
if dpkg --get-selections | grep -q clamav && [ $? = 0 ]; then VIRUS_TYPE="clamav"; else VIRUS_TYPE="none installed"; fi
VIRUS_SIG_FILE="Linux"
VIRUS_UPDATE="daily"
if grep -q "AT&T" /etc/motd && [ $? = 0 ]; then CONF_LOGIN_BANNER="Yes"; else CONF_LOGIN_BANNER="No"; fi
CONF_LOG_FORWARDING="syslog"
CONF_TIME_SYNC=`grep ^server /etc/ntp.conf | awk '{print $2}' | paste -s --delimiters=","`
REMOTE_ACCESS="ssh"
UNSECURED_PROTOCOL="All accounted for."
UNNECESSARY_PORTS="Firewall"
PATCH_STATUS=`/usr/lib/nagios/plugins/check_apt | egrep -o '\(.*\)'`
PW_MIN_LEN=8
PW_COMPLEXITY="meets policy"
PW_ROTATION="SSH Key"
PW_NO_DEFAULT="change immediately"
PW_NO_DISPLAY="hidden"
PW_REUSE="SSH Key"
PW_LOCKOUT="On Demand"
PW_LOCKOUT_DURATION="As needed"
ACCESS_SESSION_TIMEOUT="8 hours"
ACCESS_NO_DEFAULT_USER="no default accounts"
ACCESS_NO_DEFAULT_STRINGS="n/a"
ACCESS_DISABLE_GUEST="no guest accounts"
ACCESS_NO_DEFAULT_ACCOUNTS="no default accounts"
ACCESS_NINETY_DAY_INACTIVE="No"
ACCESS_UNIQUE_IDS="Yes"

LISTEN_PORTS=`netstat -lnat | grep LISTEN | awk '{print $4}' | sort | uniq | paste -s --delimiters=","`


if [ -z ${2} ]
then
# human readable

echo "Site: ${SITE}"
echo "Hostname: ${HOST}"
echo "Admin Name: ${ADMIN_NAME}"
echo "Virus Type: ${VIRUS_TYPE}"
echo "Virus Sig: ${VIRUS_SIG_FILE}"
echo "Virus Update: ${VIRUS_UPDATE}"
echo "Login Banner: ${CONF_LOGIN_BANNER}"
echo "Log Forwarding: ${CONF_LOG_FORWARDING}"
echo "Time Sync: ${CONF_TIME_SYNC}"
echo "Remote Access: ${REMOTE_ACCESS}"
echo "Unsecured Protocol: ${UNSECURED_PROTOCOL}"
echo "Unnecessary Ports: ${UNNECESSARY_PORTS}"
echo "Patch Status: ${PATCH_STATUS}"
echo "Password Min Length: ${PW_MIN_LEN}"
echo "Password Complexity: ${PW_COMPLEXITY}"
echo "Password Rotation: ${PW_ROTATION}"
echo "Password No Default: ${PW_NO_DEFAULT}"
echo "Password No Display: ${PW_NO_DISPLAY}"
echo "Password Re-use: ${PW_REUSE}"
echo "Password Lockout: ${PW_LOCKOUT}"
echo "Password Lockout Duration: ${PW_LOCKOUT_DURATION}"
echo "Session Timeout: ${ACCESS_SESSION_TIMEOUT}"
echo "Default User: ${ACCESS_NO_DEFAULT_USER}"
echo "Default Strings: ${ACCESS_NO_DEFAULT_STRINGS}"
echo "Disable Guest: ${ACCESS_DISABLE_GUEST}"
echo "Default Accounts: ${ACCESS_NO_DEFAULT_ACCOUNTS}"
echo "Listening Ports: ${LISTEN_PORTS}"
echo "90+ Days Inactive: ${ACCESS_NINETY_DAY_INACTIVE}"
echo "Unique IDs: ${ACCESS_UNIQUE_IDS}"
else
echo "'${HOST}','${REMOTE_ACCESS}','${UNSECURED_PROTOCOL}','${UNNECESSARY_PORTS}','${PATCH_STATUS}','${PW_MIN_LEN}','${PW_COMPLEXITY}','${PW_ROTATION}','${PW_NO_DEFAULT}','${PW_NO_DISPLAY}','${PW_REUSE}','${PW_LOCKOUT}','${PW_LOCKOUT_DURATION}','${ACCESS_SESSION_TIMEOUT}','${ACCESS_NO_DEFAULT_USER}','${ACCESS_NO_DEFAULT_STRINGS}','${ACCESS_DISABLE_GUEST}','${ACCESS_NO_DEFAULT_ACCOUNTS}','${ACCESS_NINETY_DAY_INACTIVE}','${ACCESS_UNIQUE_IDS}'"
fi
