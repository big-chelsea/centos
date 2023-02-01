#!/bin/bash

. function.sh

BAR

CODE [U-23] DoS 공격에 취약한 서비스 비활성화		

cat << EOF >> $result

[양호]: 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우

[취약]: 사용하지 않는 DoS 공격에 취약한 서비스가 활성화 된 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

#
vi /etc/xinetd.d/{echo,discard,daytime,chargen}



#
sudo vi echo

#
service echo
{
disable = yes
id = echo-stream
type = internal
wait = no
socket_type = stream
}



# xinetd 서비스 재시작
sudo service xinetd restart

cat $result

echo ; echo
