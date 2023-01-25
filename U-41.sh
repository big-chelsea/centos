#!/bin/bash

. function.sh

BAR

CODE [U-41] 웹 서비스(Apache) 웹 서비스 영역의 분리		

cat << EOF >> $result

[양호]: DocumentRoot를 별도의 디렉터리로 지정한 경우

[취약]: DocumentRoot를 기본 디렉터리로 지정한 경우

EOF

BAR

vi /[Apache_home]/conf/httpd.conf



# 새 DocumentRoot 디렉토리 정의
new_doc_root="/path/to/new/documentroot"

# 원본 httpd.conf 파일 백업
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak

# 이전 DocumentRoot를 새 DocumentRoot로 바꾸기
sed -i "s|DocumentRoot /usr/local/apache/htdocs|DocumentRoot $new_doc_root|g" /etc/httpd/conf/httpd.conf
sed -i "s|DocumentRoot /usr/local/apache2/htdocs|DocumentRoot $new_doc_root|g" /etc/httpd/conf/httpd.conf
sed -i "s|DocumentRoot /var/www/html|DocumentRoot $new_doc_root|g" /etc/httpd/conf/httpd.conf

# Apache 서비스 재시작
systemctl restart httpd

cat $result

echo ; echo

