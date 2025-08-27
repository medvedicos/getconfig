
#!/bin/bash

#Скачивание конфига
curl -f https://raw.githubusercontent.com/medvedicos/getconfig/refs/heads/main/getconfig --output /etc/init.d/getconfig
chmod +x /etc/init.d/getconfig
/etc/init.d/getconfig enable

echo "4 0 * * 1  /etc/init.d/getconfig" >> /etc/crontabs/root
