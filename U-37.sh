#!/bin/bash

. function.sh

BAR

CODE [U-37] 웹 서비스(Apache) 상위 디렉토리 접근 금지		

cat << EOF >> $result

[양호]: 상위 디렉터리에 이동제한을 설정한 경우

[취약]: 상위 디렉터리에 이동제한을 설정하지 않은 경우

EOF

BAR

# vieditor를 사용하여 Apache 구성 파일 열기
vi /etc/httpd/conf/httpd.conf



# Apache 구성 파일 백업
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak

# 활성화된 모든 디렉토리에서 "AllowOverrideNone"을 "AllowOverrideAuthConfig"로 교체
sed -i 's/AllowOverride None/AllowOverride AuthConfig/g' /etc/httpd/conf/httpd.conf

# Apache 서비스 재시작
systemctl restart httpd



# 지정된 디렉토리에 .htaccess 파일 생성
touch /usr/local/apache/test/.htaccess

# .htaccess 파일에 인증 설정 추가
echo "AuthName \"Authenticate Directory Users\"" >> /usr/local/apache/test/.htaccess
echo "AuthType Basic" >> /usr/local/apache/test/.htaccess
echo "AuthUserFile /usr/local/apache/test/.auth" >> /usr/local/apache/test/.htaccess
echo "Require valid-user" >> /usr/local/apache/test/.htaccess



# 사용자 ID 및 암호 생성
htpasswd -c /usr/local/apache/test/.auth test



# Apache 데몬 재시작
systemctl restart httpd

# Apache 데몬 실행 여부 확인
systemctl status httpd

cat $result

echo ; echo
