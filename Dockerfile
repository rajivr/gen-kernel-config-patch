FROM alpine:3.9

RUN \
  # apk
  # we need to add testing repository for diffstat package
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  \
  # bash is required by yocto-kernel-tools
  apk add bash && \
  apk add bison && \
  apk add coreutils && \
  apk add diffstat && \
  apk add flex && \
  apk add gcc && \
  apk add git && \
  apk add make && \
  apk add musl-dev && \
  apk add patch && \
  \
  mkdir /tmp/docker-build && \
  cd /tmp/docker-build && \
  \
  # install yocto kernel tools. checkout the specific commit
  # yocto-kernel-tools does not tag release. commit-b46b1c4 was chosen
  # based on the commit used in poky-thud-20.0.2.
  git clone git://git.yoctoproject.org/yocto-kernel-tools && \
  cd yocto-kernel-tools && \
  git checkout d6529f86fc5bcb3514953ff9fa2f51a3fbf03a0f -b commit-d6529f8 && \
  DESTDIR=/usr/local/bin make install && \
  \
  # cleanup
  cd /root && \
  rm -f /var/cache/apk/* && \
  rm -rf /tmp/docker-build
