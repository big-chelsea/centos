#!/bin/bash

. function.sh

BAR

CODE [U-40] 웹 서비스(Apache) 파일 업로드 및 다운로드 제한		

cat << EOF >> $result

[양호]: 파일 업로드 및 다운로드를 제한한 경우

[취약]: 파일 업로드 및 다운로드를 제한하지 않은 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1 

# vi 편집기를 사용하여 /[Apache_home]/conf/httpd.conf 파일 열기
APACHE_HOME=[path-to-Apache-directory]

vi ${APACHE_HOME}/conf/httpd.conf



# 설정된 모든 디렉터리의 LimitRequestBody 지시자에서 파일 사이즈 용량 제한 설정
APACHE_HOME=[path-to-Apache-directory]

LIMIT=2048000

CONF_FILES=($APACHE_HOME/conf.d/*.conf)

for FILE in "${CONF_FILES[@]}"
do
  if grep -q "LimitRequestBody" "$FILE"; then
    sed -i "s/LimitRequestBody .*/LimitRequestBody $LIMIT/g" "$FILE"
  else
    echo "LimitRequestBody $LIMIT" >> "$FILE"
  fi
done

cat $result

echo ; echo

