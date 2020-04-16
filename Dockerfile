FROM debian:bullseye
LABEL maintainer="cslev <cslev@gmx.com>"

#packages needed for FF 74.0
ENV DEPS  lsb-release \
          libatk1.0-0 \
          libc6 \
          libcairo-gobject2 \
          libcairo2 \
          libdbus-1-3 \
          libdbus-glib-1-2 \
          libfontconfig1 \
          libfreetype6 \
          libgcc1 \
          libgdk-pixbuf2.0-0 \
          libglib2.0-0 \
          libgtk-3-0 \
          libpango-1.0-0 \
          libpangocairo-1.0-0 \
          libpangoft2-1.0-0 \
          libstdc++6 \
          libx11-6 \
          libx11-xcb1 \
          libxcb-shm0 \
          libxcb1 \
          libxcomposite1 \
          libxcursor1 \
          libxdamage1 \
          libxext6 \
          libxfixes3 \
          libxi6 \
          libxrender1 \
          libxt6 \
          tar \
          bzip2 \
          wget

COPY source /docker_firefox
WORKDIR /docker_firefox

SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    dpkg-reconfigure debconf --frontend=noninteractive && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $DEPS && \
    wget -q https://ftp.mozilla.org/pub/firefox/releases/74.0/linux-x86_64/en-US/firefox-74.0.tar.bz2 && \
    tar -xjf firefox-74.0.tar.bz2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf firefox-74.0.tar.bz2 && \
    mkdir -p /usr/lib/firefox && \
    ln -s /docker_firefox/firefox/firefox /usr/lib/firefox/firefox && \
    mv bashrc_template /root/.bashrc && \
    source /root/.bashrc

# We start the script automatically
ENTRYPOINT ["/docker_firefox/firefox/firefox"]
