# Пример работы с Docker
## Создание docker-образа Caddy
Создадим контейнер на базе Debian и откроем в нём консоль bash.
Для того чтобы вводить с терминала, добавим ключ -it (--interactive --tty).
```
docker run -it --name=caddy debian 
```
Установим теперь в этом контейнере [Caddy](https://caddyserver.com/docs/install#debian-ubuntu-raspbian)
```
$ apt update && apt install curl -y
$ apt install -y debian-keyring debian-archive-keyring apt-transport-https
$ curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
$ curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
$ apt update
$ apt install caddy 
```
Создадим папку под конфиг для Caddy, а сам конфиг сохраним в файл Caddyfile
```
$ mkdir caddy
$ cd caddy
$ tee -a Caddyfile << END
# Содержимое файла Caddyfile
:8080 {
        respond "Hi LevelUp"
}
END 
```
Запустим сервис. Caddy будет отдавать ответ "Hi LevelUp" по HTTP на порту 8080:
```
$ caddy run
```
Откроем новую сессию и выполним внутри контейнера команду curl, дабы убедиться, что всё работает:
```
$ docker exec -it caddy curl localhost:8080 
```
Выйдем из контейнера и выполним:
```
$ docker commit caddy caddy-image 
```
это создаст новый образ на основе тех изменений, которые были сделаны в контейнере

Только что мы создали образ с Caddy на базе Debian. Docker-демон финализировал верхний слой, в котором вы работали с контейнером, и добавил этот слой в локальный репозиторий.
Можно проверить, что образ действительно создался:
```
$ docker images
```
Если сделать `$ docker history caddy-image` — увидите, что образ состоит из других слоёв:
```
$ docker history caddy-image                                               
IMAGE          CREATED         CREATED BY                                      SIZE      COMMENT
dcedfb1b65ec   7 seconds ago   bash                                            128MB
676aedd4776f   2 weeks ago     /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>      2 weeks ago     /bin/sh -c #(nop) ADD file:1e4dd5dab602337b5…   117MB 
```
А слои образа, на основе которого мы запускали контейнер для Caddy, выглядят так:
```
$ docker history debian
IMAGE          CREATED       CREATED BY                                      SIZE      COMMENT
676aedd4776f   2 weeks ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>      2 weeks ago   /bin/sh -c #(nop) ADD file:1e4dd5dab602337b5…   117MB 
```
Видно, что оба образа состоят из 2 одинаковых слоев, только в образе caddy-image сверху добавился новый слой.

## Запуск контейнера из ранее созданного образа Caddy
Теперь запустим новый контейнер из нашего образа-шаблона caddy-image:
```
$ docker run --rm --name caddy caddy-image caddy run --config /caddy/Caddyfile
```
Ключ `--rm` нужен, чтобы контейнер автоматически удалился, после остановки. 
Проверим, что всё ок:
```
$ docker exec -it caddy curl http://localhost:8080/
```

## Создание docker-образа Caddy через Dockerfile
Создадим конфиг Caddy:
```
:8080 {
        respond "Hi LevelUp"
}
```
Создадим Dockerfile:
```
FROM debian:buster
RUN apt update
RUN apt install -y curl debian-keyring debian-archive-keyring apt-transport-https
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | tee /etc/apt/trusted.gpg.d/caddy-stable.asc
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
RUN apt update
RUN apt install -y caddy
RUN mkdir caddy
RUN cd caddy
COPY ./Caddyfile /caddy/Caddyfile
WORKDIR /caddy
EXPOSE 8080/tcp
ENTRYPOINT ["caddy","run"] 
```
`FROM` — какой базовый образ взять.

`RUN` — какая команда выполнится внутри данного образа.

`COPY` — просто копирует файл из файловой системы хоста в файловую систему контейнера; сначала надо указать файл с хоста, а затем путь в контейнере.

`ADD` — может не просто копировать файлы, как COPY, но и, например, скачивать по http, поэтому инструкция COPY предпочтительней при создании образов, потому что делае добавление файлов в образ более прозрачным.

`WORKDIR` — текущий каталог при старте контейнера.

`EXPOSE` — список портов, используемых контейнеризованным процессом. Но реально порты не открываются наружу это инструкцией, это лишь для справки тем, кто использует данный образ.

`ENTRYPOINT` — какой процесс необходимо запустить при старте контейнера и его аргументы

Для оптимизации итогового образа можно было бы этот Dockerfile переписать так:
```
FROM debian:buster-20220527
RUN apt update && \ 
    apt install -y curl debian-keyring debian-archive-keyring apt-transport-https && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt update && apt install -y caddy
WORKDIR /caddy
COPY ./Caddyfile /caddy/Caddyfile
EXPOSE 8080/tcp
ENTRYPOINT ["caddy","run"] 
```
Выполним:
```
$ docker build -t my-caddy-image:0.0.1 .
```
Проверим, что образ попал в локальный репозиторий:
```
$ docker images 
```
Теперь запустим контейнер, созданный из нашего образа. Если остался старый контейнер, то его можно удалить с помощью docker rm, а `docker rm $(docker ps -qa)` удалит все контейнеры. `ps -qa` покажет короткие id всех контейнеров.
```
$  docker run -d --rm --name caddy my-caddy-image:0.0.1
```
Ключ `-d` — чтобы запустить контейнер в фоне и получить обратно консоль.
Проверим, что контейнер стартанул:
```
$  docker ps
```
Через команду `docker logs -f <имя контейнера>` можно посмотреть логи процесса внутри контейнера.
Ключ `-f` — чтобы логи показывались в реальном времени, а не просто вывелись один раз.
```
$  docker logs -f caddy 
```
Нажмём `Ctrl+C` и выйдем из просмотра логов.
Проверим, что Caddy отдаёт на порту 8080 страничку в контейнере:
```
$  docker exec -it caddy curl localhost:8080
```
Удалим текущий контейнер Caddy:
```
$ docker rm -f caddy
```
Выполним:
```
$ docker run -d --restart=always -p 9999:8080 --name=caddy my-caddy-image:0.0.1 
``` 
Теперь Caddy будет отдавать страничку на порту 9999 хостовой машины, и, если контейнер упадёт или хост перезагрузят, докер-демон его перезапустит. А вообще можно указать конечное число попыток рестарта. Плохо постоянно перезапускать сервис, если он некорректно работает.

## Монтирование папок с хоста в контейнер
Создадим папку c конфигом Caddy:
```
$ mkdir -p ~/caddy/conf
//и в ней создадим файл Caddyfile
$ cd ~/caddy/conf
$ tee -a Caddyfile << END 
 :8080 {
        respond "Hi LevelUp, DevOps and Docker"
   }
END
```
Возьмём наш образ `my-caddy-image:0.0.1`, создадим из него контейнер, и примонтируем нашу папку с конфигом, которая заменит те, что были в образе:
```
$  docker run --rm --name caddy -p 9999:8080 -v ~/caddy/conf:/caddy my-caddy-image:0.0.1 
```
Проверим в браузере страничку `<IP хоста студента>:9999`.
Мы смонтировали папку с хоста. Теперь конфиги можно править снаружи. Подобный приём ещё можно использовать, если хочешь, чтобы после уничтожения контейнера некоторые данные остались на хосте, а не сгинули вместе с контейнером.
