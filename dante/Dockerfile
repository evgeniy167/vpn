FROM vimagick/dante

ARG SOCKS_USER
ARG SOCKS_PASS

RUN useradd -m -s /usr/sbin/nologin "$SOCKS_USER" && \
    echo "$SOCKS_USER:$SOCKS_PASS" | chpasswd
