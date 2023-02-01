#!/bin/bash

. function.sh

BAR

CODE [U-20] Anonymous FTP 비활성화		

cat << EOF >> $result

[양호]: Anonymous FTP (익명 ftp) 접속을 차단한 경우

[취약]: Anonymous FTP (익명 ftp) 접속을 차단하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# /etc/passwd 파일에서 FTP 또는 익명 계정을 삭제
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# 삭제할 계정의 사용자 이름 가져오기
read -p "Enter the username of the account to delete: " username

# 계정이 /etc/passwd 파일에 있는지 확인
grep -q "^$username:" /etc/passwd
if [ $? -eq 0 ]; then
    # /etc/passwd 파일에서 계정 삭제
    sed -i "/^$username:/d" /etc/passwd
    echo "Account $username has been deleted from /etc/passwd"
else
    echo "Account $username does not exist in /etc/passwd"
fi



# 사용자가 루트인지 확인
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# proftpd.conf 파일의 위치를 확인
proftpd_conf_file=$(find / -name proftpd.conf 2>/dev/null)

if [ ! -f "$proftpd_conf_file" ]; then
    echo "proftpd.conf file not found"
    exit 1
fi

# 익명 설정과 관련된 User 및 UserAlias 항목에 주석을 추가
sed -i '/^User \+anonymous/s/^/#/' $proftpd_conf_file
sed -i '/^UserAlias/s/^/#/' $proftpd_conf_file
echo "User and UserAlias items related to anonymous settings have been annotated in $proftpd_conf_file"



# 사용자가 루트인지 확인
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# vsftpd.conf 파일이 있는지 확인
if [ ! -f "/etc/vsftpd/vsftpd.conf" ] && [ ! -f "/etc/vsftpd.conf" ]; then
    echo "vsftpd.conf file not found"
    exit 1
fi

# Anonymous_enable을 NO로 설정
if [ -f "/etc/vsftpd/vsftpd.conf" ]; then
    sed -i 's/^anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf
    echo "anonymous_enable set to NO in /etc/vsftpd/vsftpd.conf"
elif [ -f "/etc/vsftpd.conf" ]; then
    sed -i 's/^anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd.conf
    echo "anonymous_enable set to NO in /etc/vsftpd.conf"
fi

cat $result

echo ; echo
