# Dockerfile for Duplicacy Web
FROM alpine:latest

# Constants
ARG DUPLICACY_WEB_X64_SHA256="88383f7fea8462539cab7757dfa167bf42e37cbc19531b9de97373bc20efd317"
ARG DUPLICACY_WEB_ARM64_SHA25="8ff18950d2c2d8ba9774c1b0add992ebdcdf984ed36a446cd8b7a8623088ee37"
ARG DUPLICACY_WEB_VERSION="1.7.2"
ARG DOWNLOAD_HOST="https://acrosync.com/duplicacy-web"
ARG DUPLICACY_WEB_X64_URL="${DOWNLOAD_HOST}/duplicacy_web_linux_x64_${DUPLICACY_WEB_VERSION}"
ARG DUPLICACY_WEB_ARM64_URL="${DOWNLOAD_HOST}/duplicacy_web_linux_arm64_${DUPLICACY_WEB_VERSION}"

# Install dependencies
RUN apk add --update --no-cache \
    ca-certificates \
    tzdata \
    wget \
    && rm -rf /var/cache/apk/*

# Set timezone
ENV TZ="America/New_York"

# Download version depending on architecture
RUN if [ "$(uname -m)" = "x86_64" ]; then \
    wget -O /usr/local/bin/duplicacy_web ${DUPLICACY_WEB_X64_URL} \
    && echo "${DUPLICACY_WEB_X64_SHA256}  /usr/local/bin/duplicacy_web" | sha256sum -c - \
    ; else \
    wget -O /usr/local/bin/duplicacy_web ${DUPLICACY_WEB_ARM64_URL} \
    && echo "${DUPLICACY_WEB_ARM64_SHA25}  /usr/local/bin/duplicacy_web" | sha256sum -c - \
    ; fi
RUN chmod +x /usr/local/bin/duplicacy_web

RUN mkdir -p /var/lib/dbus
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3875

ENTRYPOINT ["/entrypoint.sh"]