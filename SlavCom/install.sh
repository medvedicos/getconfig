#!/bin/bash

#Скачивание конфига
curl -f https://raw.githubusercontent.com/medvedicos/getconfig/refs/heads/main/SlavCom/getconfig --output /etc/init.d/getconfig
chmod +x /etc/init.d/getconfig
/etc/init.d/getconfig enable
/etc/init.d/getconfig start

curl -f https://raw.githubusercontent.com/medvedicos/getconfig/refs/heads/main/getexclude --output /etc/init.d/getexclude
chmod +x /etc/init.d/getexclude
/etc/init.d/getexclude enable
/etc/init.d/getexclude start

echo "4 0 * * 1  /etc/init.d/getconfig" >> /etc/crontabs/root
echo "4 0 * * 1  /etc/init.d/getexclude" >> /etc/crontabs/root
