#!/bin/bash

. function.sh

BAR

CODE [U-19] finger 서비스 비활성화		

cat << EOF >> $result

[양호]: Finger 서비스가 비활성화 되어 있는 경우

[취약]: Finger 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# vi 편집기를 이용하여 /etc/xinetd.d/finger 파일 열기
sudo vi /etc/xinetd.d/finger



# finger 파일 설정
echo "service finger
{
socket_type = stream
wait = no
user = nobody
server = /usr/sbin/in.fingerd
disable = yes
}" > /etc/xinetd.d/finger



# xinetd 서비스 재시작
systemctl restart xinetd

cat $result

echo ; echo
