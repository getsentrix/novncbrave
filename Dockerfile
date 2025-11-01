FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

LABEL maintainer="gitxpresso"
LABEL org.opencontainers.image.source "https://github.com/getsentrix/Browsers-NoVNC"

ENV TITLE=Brave_NoVNC

RUN apt-get update && \
    apt-get install -y curl wget dbus-x11 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy only brave startup scripts
COPY bravenovnc.sh /bravenovnc.sh
COPY braveservice /etc/init.d/bravenovnc

RUN chmod +x /bravenovnc.sh /etc/init.d/bravenovnc

EXPOSE 3000

CMD ["/bravenovnc.sh"]
