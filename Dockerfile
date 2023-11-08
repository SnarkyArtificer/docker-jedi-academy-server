
FROM alpine:3.18 as unzipped_files

RUN apk add --no-cache unzip=6.0-r14

WORKDIR /tmp
COPY jalinuxded_1011.zip jalinuxded_1011.zip
RUN unzip -d jedi_academy/ jalinuxded_1011.zip

FROM debian:12.2-slim

# requires the lib32 libraries
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      lib32stdc++6=12.2.0-14 \
      && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m jediacademy

RUN mkdir -p /files && \
  mkdir -p /usr/local/games/ja/ && \
  ln -s /files /usr/local/games/ja/base && \
  chown -R jediacademy /usr/local/games/ja/ /files && \
  chmod +wr -R /usr/local/games/ja/

# main program
COPY --from=unzipped_files /tmp/jedi_academy/libcxa.so.1 /usr/lib/libcxa.so.1
COPY --from=unzipped_files /tmp/jedi_academy/linuxjampded /usr/local/games/ja/linuxjampded

# default unmodded files
COPY --from=unzipped_files /tmp/jedi_academy/jampgamei386.so /tmp/jampgamei386.so
COPY --from=unzipped_files /tmp/jedi_academy/server.cfg /tmp/server.cfg

RUN chmod a+x /usr/local/games/ja/linuxjampded && \
    chmod a+x /usr/lib/libcxa.so.1

WORKDIR /usr/local/games/ja/
COPY source/run.sh run.sh
RUN chown jediacademy run.sh && \
    chmod a+x run.sh

USER jediacademy
VOLUME /files
ENTRYPOINT ["/usr/local/games/ja/run.sh"]

