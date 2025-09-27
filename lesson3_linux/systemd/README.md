# systemd

Создайте два простых учебных юнита:
- Первый сервис-юнит будет выполнять команду, а второй запускать этот сервис-юнит по расписанию.
- Демон monitoring.service выполняет команду free, которая выводит информацию об оперативной памяти:

```
[Unit]
Description=Example monitoring service

[Service]
# Тип запуска сервиса — oneshot для однократного запуска
Type=oneshot
# Запускаем команду free
ExecStart=/usr/bin/free -ht

[Install]
WantedBy=multi-user.target
```

Скопируйте содержимое в файл `/etc/systemd/system/monitoring.service` и запустите команду `systemctl daemon-reload` для перечитывания конфигурации systemd. Теперь можно запустить сервис командой `systemctl start monitoring.service` и посмотреть результаты его работы командой `systemctl status monitoring.service`:

```
$ systemctl status monitoring
○ monitoring.service - Example monitoring service
     Loaded: loaded (/etc/systemd/system/monitoring.service; disabled; vendor preset: enabled)
     Active: inactive (dead)

Aug 27 16:05:42 test systemd[1]: Starting Example monitoring service...
Aug 27 16:05:42 test free[1834]:                total        used        free      shared  buff/cache   available
Aug 27 16:05:42 test free[1834]: Mem:         4004900      193360     3354012        1108      457528     3578568
Aug 27 16:05:42 test free[1834]: Swap:              0           0           0
Aug 27 16:05:42 test systemd[1]: monitoring.service: Deactivated successfully.
Aug 27 16:05:42 test systemd[1]: Finished Example monitoring service.
```

Не выполняйте команду `systemctl enable monitoring.service`, мы воспользуемся юнитом специального типа — **timer**:
```
[Unit]
Description=Example monitoring timer

[Timer]
# Этот таймер запускает сервис monitoring.service
Unit=monitoring.service
# Каждую минуту
OnCalendar=*-*-* *:*:00

[Install]
WantedBy=timers.target
```
Скопируйте содержимое в файл `/etc/systemd/system/monitoring.timer` и запустите команду `systemctl daemon-reload` для перечитывания конфигурации systemd. Теперь можно выполнить команду `systemctl start monitoring.timer` и через минуту проверить статус нашего сервиса: 
```
$ systemctl status monitoring.service
○ monitoring.service - Example monitoring service
     Loaded: loaded (/etc/systemd/system/monitoring.service; disabled; vendor preset: enabled)
     Active: inactive (dead) since Sun 2023-08-27 16:14:03 UTC; 33s ago
TriggeredBy: ● monitoring.timer
    Process: 1963 ExecStart=/usr/bin/free (code=exited, status=0/SUCCESS)
   Main PID: 1963 (code=exited, status=0/SUCCESS)
        CPU: 2ms

Aug 27 16:14:03 test systemd[1]: Starting Example monitoring service...
Aug 27 16:14:03 test free[1963]:                total        used        free      shared  buff/cache   available
Aug 27 16:14:03 test free[1963]: Mem:         4004900      197464     3348272        1108      459164     3574420
Aug 27 16:14:03 test free[1963]: Swap:              0           0           0
Aug 27 16:14:03 test systemd[1]: monitoring.service: Deactivated successfully.
Aug 27 16:14:03 test systemd[1]: Finished Example monitoring service.
```
**Юниты с типом timer — это удобный способ организации запуска периодических задач на смену cron-демону.**