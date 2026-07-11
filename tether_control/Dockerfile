ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM ${BUILD_FROM}

RUN apk add --no-cache jq libstdc++ libgcc icu-libs libgpiod gcompat libc6-compat \
    && if [ -e /usr/lib/libgpiod.so.2 ] && [ ! -e /usr/lib/libgpiod.so.1 ]; then ln -s /usr/lib/libgpiod.so.2 /usr/lib/libgpiod.so.1; fi \
    && if [ -e /lib/libgpiod.so.2 ] && [ ! -e /lib/libgpiod.so.1 ]; then ln -s /lib/libgpiod.so.2 /lib/libgpiod.so.1; fi \
    && if [ -e /usr/glibc-compat/lib/ld-linux-aarch64.so.1 ] && [ ! -e /lib/ld-linux-aarch64.so.1 ]; then ln -s /usr/glibc-compat/lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1; fi \
    && if [ -e /lib/ld-musl-aarch64.so.1 ] && [ ! -e /lib/ld-linux-aarch64.so.1 ]; then ln -s /lib/ld-musl-aarch64.so.1 /lib/ld-linux-aarch64.so.1; fi
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

WORKDIR /app
COPY TCBin /app/TCBin
COPY icon.png /app/icon.png
COPY UI /app/UI
COPY run.sh /run.sh
RUN chmod a+x /run.sh /app/TCBin

CMD [ "/run.sh" ]
