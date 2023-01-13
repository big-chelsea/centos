#!/bin/bash

. function.sh

BAR

CODE [U-01] root 계정 원격 접속 제한

cat << EOF >> $result

[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우

[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우

EOF

BAR

# Remove pts/0 to pts/x settings from /etc/securety file
sudo sed -i 's/^[^#]*pts\/[0-9]/#&/g' /etc/securety

# Backup the /etc/pam.d/login file
sudo cp /etc/pam.d/login /etc/pam.d/login.bak

# Annotate or modify the /etc/pam.d/login file
sudo vi /etc/pam.d/login

# Insert new settings to /etc/pam.d/login file
sudo echo "auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800" >> /etc/pam.d/login



# Backup the /etc/securety file
sudo cp /etc/securety /etc/securety.bak

# Remove pts/x-related settings from /etc/securety file
sudo sed -i '/pts\/[0-9]/d' /etc/securety



# Open /etc/ssh/sshd_config file with vi editor
sudo vi /etc/ssh/sshd_config

cat $result

echo ; echo