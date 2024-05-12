#!/bin/bash
# Войти в главную директорию
cd ~
# Установить зависимости
apt -y install dmidecode hwdata ucf hdparm
apt -y install perl libuniversal-require-perl libwww-perl libparse-edid-perl
apt -y install libproc-daemon-perl libfile-which-perl libhttp-daemon-perl
apt -y install libxml-treepp-perl libyaml-perl libnet-cups-perl libnet-ip-perl
apt -y install libdigest-sha-perl libsocket-getaddrinfo-perl libtext-template-perl
apt -y install libxml-xpath-perl
# Скачать пакет FusionInventory
wget https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.1/fusioninventory-agent_2.5.1-1_all.deb
# Установить пакет
dpkg -i fusioninventory-agent_2.5.1-1_all.deb
# Переопределить параметр сервера, на котором запущен FusionInventory
sed -i 's~#server = http://server.domain.com/glpi/plugins/fusioninventory/~server = http://myglpiserver.com/glpi/plugins/fusioninventory/~1' /etc/fusioninventory/agent.cfg
# Логи
sed -i 's~#logfile = /var/log/fusioninventory.log~logfile = /var/log/fusioninventory.log~1' /etc/fusioninventory/agent.cfg
# Запускаем службу
systemctl restart fusioninventory-agent
sleep 10
# Инветнаризируемся
pkill -USR1 -f -P 1 fusioninventory-agent