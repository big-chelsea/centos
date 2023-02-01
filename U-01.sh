#!/bin/bash

. function.sh

BAR

CODE [U-01] root 계정 원격 접속 제한

cat << EOF >> $result

[양호]: 원격 서비스를 사용하지 않거나 사용시 직접 접속을 차단한 경우

[취약]: root 직접 접속을 허용하고 원격 서비스를 사용하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

# /etc/securety 파일에서 pts/0 tops/x 설정 제거
sudo sed -i 's/^[^#]*pts\/[0-9]/#&/g' /etc/securety

# /etc/pam.d/login 파일 백업
sudo cp /etc/pam.d/login /etc/pam.d/login.bak

# /etc/pam.d/login 파일에 주석을 달거나 수정
sudo vi /etc/pam.d/login

# /etc/pam.d/login 파일에 새 설정 삽입
sudo echo "auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800" >> /etc/pam.d/login



# /etc/securety 파일 백업
sudo cp /etc/securety /etc/securety.bak

# /etc/securety 파일에서 pts/x 관련 설정 제거
sudo sed -i '/pts\/[0-9]/d' /etc/securety



# vi 편집기를 사용하여 /etc/ssh/sshd_config 파일 열기
sudo vi /etc/ssh/sshd_config

cat $result

echo ; echo