#!/bin/bash

. function.sh

BAR

CODE [U-14] 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정		

cat << EOF >> $result

[양호]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되
어 있고, 홈 디렉터리 환경변수 파일에 root와 소유자만 쓰기 권한이 부여
된 경우

[취약]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되
지 않고, 홈 디렉터리 환경변수 파일에 root와 소유자 외에 쓰기 권한이 
부여된 경우

EOF

BAR

# 지정된 디렉토리 아래의 모든 파일 및 디렉토리의 소유자를 new_username 및 new_groupname으로 변경
sudo chown -R new_username:new_groupname /path/to/directory

#
sudo chown -R webuser:webgroup /var/www/html



# 지정된 디렉토리에 있는 모든 파일 및 디렉토리의 권한을 755로 재귀적으로 변경
sudo chmod -R 755 /path/to/directory

cat $result

echo ; echo
