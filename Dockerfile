FROM alpine:3.6

COPY [ \
  "./docker-extras/*", \
  "/tmp/docker-build/" \
]

RUN \
  # apk
  # we need to add testing repository for diffstat package
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  \
  # bash is required by yocto-kernel-tools
  apk add bash && \
  apk add diffstat && \
  apk add gcc && \
  apk add git && \
  apk add make && \
  apk add musl-dev && \
  apk add patch && \
  \
  cd /tmp/docker-build && \
  \
  # install yocto kernel tools. checkout the specific commit
  git clone git://git.yoctoproject.org/yocto-kernel-tools && \
  cd yocto-kernel-tools && \
  git checkout b46b1c4f0973bf1eb09cf1191f5f4e69bcd0475d -b commit-b46b1c4 && \
  patch -p1 < ../tools-merge_config-sh-fix.patch && \
  DESTDIR=/usr/local/bin make install && \
  \
  # cleanup
  cd /root && \
  rm -f /var/cache/apk/* && \
  rm -rf /tmp/docker-build
