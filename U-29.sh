#!/bin/bash

. function.sh

BAR

CODE [U-29] tftp, talk 서비스 비활성화		

cat << EOF >> $result

[양호]: tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우

[취약]: tftp, talk, ntalk 서비스가 활성화 되어 있는 경우

EOF

BAR

# vi를 사용하여 디렉토리 "/etc/xinetd.d/"에서 tftp, talk, ntalk 파일 열기
for service in tftp talk ntalk; do
    if [ -f "/etc/xinetd.d/$service" ]; then
        vi "/etc/xinetd.d/$service"
    fi
done



# tftp 파일 생성
echo "service tftp
{
socket_type = dgram
protocol = udp
wait = yes
user = root
server = /usr/sbin/in.tftpd
server_args = -s /tftpboot
disable = yes
}" > /etc/xinetd.d/tftp

# talk 파일 생성
echo "service tftp
{
socket_type = dgram
protocol = udp
wait = yes
user = root
server = /usr/sbin/in.tftpd
server_args = -s /tftpboot
disable = yes
}" > /etc/xinetd.d/talk

# ntalk 파일 생성
echo "service tftp
{
socket_type = dgram
protocol = udp
wait = yes
user = root
server = /usr/sbin/in.tftpd
server_args = -s /tftpboot
disable = yes
}" > /etc/xinetd.d/ntalk



# xinetd 서비스 재시작
systemctl restart xinetd

cat $result

echo ; echo
