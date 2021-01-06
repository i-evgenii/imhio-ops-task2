# imhio-ops-task2

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
> rm main.zip <br>
> wget https://github.com/i-evgenii/imhio-ops-task2/archive/main.zip <br>
> unzip main.zip <br>
> rm main.zip <br>
> cd imhio-ops-task2-main

3. Обновить ip-адреса в файле hosts

4. Временно разрешить все ssh соединения в Firewall

5. Выполнить сценарий Ansible
> ansible-playbook ./imhio-ops-task2.yml -i hosts
