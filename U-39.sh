#!/bin/bash

. function.sh

BAR

CODE [U-39] 웹 서비스(Apache) 링크 사용 금지		

cat << EOF >> $result

[양호]: 심볼릭 링크, aliases 사용을 제한한 경우

[취약]: 심볼릭 링크, aliases 사용을 제한하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# vi editor를 사용하여 Apache 구성 파일 열기
vi /etc/httpd/conf/httpd.conf



# Apache 구성 파일 백업
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak

# 활성화된 모든 디렉토리에서 "Options Indexs FollowSymLinks"를 "Options Indexs"로 변경
sed -i 's/Options Indexes FollowSymLinks/Options Indexes/g' /etc/httpd/conf/httpd.conf

# Apache 서비스 재시작
systemctl restart httpd

cat $result

echo ; echo

