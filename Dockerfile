FROM --platform=$BUILDPLATFORM ubuntu:20.04

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
ARG TIMEZONE

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="TTK_Base_Image" \
  org.label-schema.description="TorToolkit based image" \
  org.label-schema.url="https://rokibhasansagar.github.io" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url=$VCS_URL \
  org.label-schema.vendor="Rokib Hasan Sagar" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

LABEL maintainer="fr3akyphantom <rokibhasansagar2014@outlook.com>"

WORKDIR /torapp

ENV DEBIAN_FRONTEND noninteractive

RUN chmod -R 777 /torapp

RUN apt-get -qq update -y && \
    apt-get -qq install -y --no-install-recommends \
        curl git wget aria2 ca-certificates \
        python3 python3-pip \
        tzdata \
        software-properties-common gnupg2 gpg-agent \
        ffmpeg mediainfo unzip p7zip-full p7zip-rar \
        libcrypto++-dev libssl-dev libc-ares-dev libcurl4-openssl-dev \
        libsqlite3-dev libsodium-dev && \
    ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
    apt-get -qq install -y qbittorrent-nox && \
    curl -sL https://rclone.org/install.sh | bash && \
    apt-get autoremove -qy && \
    case $TARGETPLATFORM in \
    "linux/amd64") \
        export plat=amd64 \
        ;; \
    "linux/386") \
        export plat=i386 \
        ;; \
    "linux/arm64") \
        export plat=arm64 \
        ;; \
    "linux/arm/v7") \
        export plat=armv7 \
        ;; \
    "linux/arm/v6") \
        export plat=armv6 \
        ;; \
    esac && \
    curl -sL https://github.com/viswanathbalusu/megasdkrest/releases/download/v0.1.14/megasdkrest-${plat} -o /usr/local/bin/megasdkrest && \
    chmod +x /usr/local/bin/megasdkrest
