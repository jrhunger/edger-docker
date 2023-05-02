FROM ubuntu:20.04

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install \
    sudo \
    git \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y git wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 python3-pip curl
# above line installs what linux_install.sh installs so we can see the other stuff it does in the install layer

RUN useradd -u 1000 -d /app app \
  && echo 'app ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && mkdir -p /app \
  && chown -R 1000:1000 /app \
  && addgroup app dialout

USER 1000

WORKDIR /app

COPY linux_install.sh /app/linux_install.sh

RUN bash linux_install.sh --edger=/app/edger --idf=/app/esp-idf --install
