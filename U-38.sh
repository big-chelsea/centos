#!/bin/bash

. function.sh

BAR

CODE [U-38] 웹 서비스(Apache) 불필요한 파일 제거		

cat << EOF >> $result

[양호]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되어 있는 경우

[취약]: 기본으로 생성되는 불필요한 파일 및 디렉터리가 제거되지 않은 경우

EOF

BAR

# 루트 사용자로 실행하여 특정 디렉터리 및 해당 파일을 제거
rm -rf /path/to/directory



# 패키지가 여전히 설치되어 있는지 확인
if [ -d "/path/to/package" ]; then
  echo "Package is still installed"
else
  echo "Package has been uninstalled"
fi

# 패키지의 디렉터리 내용을 나열하며, 패키지가 제거되면 "No such file or directory"를 반환
ls /path/to/package



# 불필요한 파일 또는 디렉터리 제거
rm -rf /path/to/unnecessary/files/*

find /path/to/unnecessary/files -type f -mtime +30 -delete

cat $result

echo ; echo

