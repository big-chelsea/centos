#!/bin/bash

. function.sh

BAR

CODE [U-21] r 계열 서비스 비활성화		

cat << EOF >> $result

[양호]: 불필요한 r 계열 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 r 계열 서비스가 활성화 되어 있는 경우

EOF

BAR

# vi 편집기를 이용하여 “/etc/xinetd.d/” 디렉터리 내 rlogin, rsh, rexec 파일 열기
FILES=(/etc/xinetd.d/rlogin /etc/xinetd.d/rsh /etc/xinetd.d/rexec)

for FILE in "${FILES[@]}"
do
    vi $FILE
done



# rlogin 파일 생성
echo "service rlogin
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > /etc/xinetd.d/rlogin

# rsh 파일 생성
echo "service rlogin
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > /etc/xinetd.d/rsh

# rexec 파일 생성
echo "service rlogin
{
socket_type = stream
wait = no
user = nobody
log_on_success += USERID
log_on_failure += USERID
server = /usr/sdin/in.fingerd
disable = yes
}" > /etc/xinetd.d/rexec

# xinetd 서비스 재시작
systemctl restart xinetd


cat $result

echo ; echo
