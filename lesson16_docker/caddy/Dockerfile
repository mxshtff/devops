# FROM debian:latest
# RUN apt update
# RUN apt install -y curl debian-keyring debian-archive-keyring apt-transport-https
# RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
# RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | tee /etc/apt/trusted.gpg.d/caddy-stable.asc
# RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
# RUN apt update
# RUN apt install -y caddy
# RUN mkdir caddy
# RUN cd caddy
# COPY ./Caddyfile /caddy/Caddyfile
# WORKDIR /caddy
# EXPOSE 8080/tcp
# ENTRYPOINT ["caddy","run"] 

FROM debian:latest
RUN apt update && \ 
    apt install -y curl debian-keyring debian-archive-keyring apt-transport-https && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt update && apt install -y caddy && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /caddy
COPY ./Caddyfile /caddy/Caddyfile
EXPOSE 8080/tcp
ENTRYPOINT ["caddy","run"] 