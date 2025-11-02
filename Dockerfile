FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

LABEL maintainer="getsentrix"
LABEL org.opencontainers.image.source="https://github.com/getsentrix/novncbrave"

ENV TITLE=Brave

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl wget gnupg dbus-x11 && \
    curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list && \
    apt-get update && \
    apt-get install -y brave-browser && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /config/.cache

RUN mkdir -p /etc/services.d/brave && \
    echo '#!/usr/bin/env bash' > /etc/services.d/brave/run && \
    echo 'export DISPLAY=:1' >> /etc/services.d/brave/run && \
    echo 'exec s6-setuidgid abc brave-browser --no-sandbox --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --no-zygote --homepage=https://google.com' >> /etc/services.d/brave/run && \
    chmod +x /etc/services.d/brave/run

EXPOSE 3000
