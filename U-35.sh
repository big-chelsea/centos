#!/bin/bash

. function.sh

BAR

CODE [U-35] 웹 서비스(Apache) 디렉토리 리스팅 제거		

cat << EOF >> $result

[양호]: 디렉터리 검색 기능을 사용하지 않는 경우

[취약]: 디렉터리 검색 기능을 사용하는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# vi를 사용하여 httpd.conf 파일 열기
vi /[Apache_home]/conf/httpd.conf



# 모든 디렉토리의 옵션 표시기에서 인덱스 제거 옵션
find / -type d -name '*' -exec sed -i 's/Options Indexes/Options/g' {}/.htaccess \;

# 모든 디렉터리의 옵션 표시기에서 FollowSymlinks 제거 옵션
find / -type d -name '*' -exec sed -i 's/FollowSymLinks//g' {}/.htaccess \;

cat $result

echo ; echo

