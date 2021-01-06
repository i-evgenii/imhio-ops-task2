# imhio-ops-task2
## Требования:
- разместить приложение tcg на первом инстансе
- для настройки приложения скопировать пример конфига: /etc/tcg/tcg.config.sample.json -> /etc/tcg/tcg.json
- на втором инстансе настроить RDMS MySQL любой современной версии
- файлы MySQL разместить на внешнем volume
- создать БД для приложения и настроить к ней доступ по внутренней сети
- в конфигурационном файле приложения указать данные доступа к базе данных, инициализация таблиц произойдет автоматически при первом запуске
- запустить приложение tcg через systemd , пакет приложения уже содержит все необходимые настройки, обеспечить автозагрузку при старте системы, дополнительную информацию о приложении можно найти после установки пакета в readme файле расположенном в директории /usr/share/tcg

## На каждой виртуальной машине:

1. Создать пользователя для Ansible
> sudo adduser a-user <br>
> sudo passwd a-user

2. Добавить права новому пользователю
> sudo vi /etc/sudoers
```
a-user  ALL=(ALL)       ALL
```

3. Разрешить вход с паролем в SSH
> sudo vi /etc/ssh/sshd_config
```
PasswordAuthentication yes
```

> sudo systemctl restart sshd

## В консоли CloudShell:
1. Установить Ansible:
> sudo pip install ansible <br>
> sudo apt-get install sshpass


2. Загрузить и распаковать сценарий Ansible
> cd .. <br>
> rm main.zip <br>
> wget https://github.com/i-evgenii/imhio-ops-task2/archive/main.zip <br>
> unzip main.zip <br>
> rm main.zip <br>
> cd imhio-ops-task2-main

3. Обновить ip-адреса/пароли в файле hosts

4. Временно разрешить все ssh соединения в Firewall
> gcloud compute firewall-rules update publicnet-allow-ssh --source-ranges "0.0.0.0/0"

5. Выполнить сценарий Ansible, в параметрах указать ip-адрес приватной сети privatenet-us-vm2
> ansible-playbook ./imhio-ops-task2.yml -i hosts --extra-vars "dbip=172.16.0.2 dbrootpwd=mysql-root-password dbusrpwd=mysql-tcg-password"

6. Вернуть защиту ssh соединения в Firewall
> gcloud compute firewall-rules update publicnet-allow-ssh --source-ranges "35.235.240.0/20,109.163.216.0/21"
