#!/bin/bash

. function.sh

BAR

CODE [U-36] 웹 서비스(Apache) 프로세스 권한 제한		

cat << EOF >> $result

[양호]: Apache 데몬이 root 권한으로 구동되지 않는 경우

[취약]: Apache 데몬이 root 권한으로 구동되는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# 새 사용자 및 그룹 생성
useradd -m -s /sbin/nologin newuser
groupadd newgroup

# 디렉터리 소유권을 새 사용자 및 그룹으로 변경
chown newuser:newgroup /path/to/directory



# Apache 서비스 재시작
systemctl restart httpd

# Apache 서비스 실행 여부 확인
systemctl status httpd

cat $result

echo ; echo

