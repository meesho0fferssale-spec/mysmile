FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt update && apt install -y \
    xfce4 xfce4-terminal \
    tightvncserver \
    dbus-x11 \
    firefox-esr \
    wget curl \
    ca-certificates \
    xz-utils \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN wget -q https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz && \
    tar -xzf v1.2.0.tar.gz && \
    mv noVNC-1.2.0 /noVNC && \
    rm v1.2.0.tar.gz

# VNC config
RUN mkdir -p /root/.vnc && \
    echo 'admin123' | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd && \
    echo '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec dbus-launch xfce4-session &' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

# Startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8900
CMD ["/start.sh"]
