FROM ubuntu:trusty
MAINTAINER Patrick McAfee

RUN apt-get update && \
	    DEBIAN_FRONTEND=noninteractive apt-get install -y lib32stdc++6 curl unzip && \
	    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /files && \
  mkdir -p /usr/local/games/ja/ && \
  ln -s /files /usr/local/games/ja/base

# get jedi academy dedicated
RUN curl -L -o /tmp/jedi_academy.zip https://jkhub.org/files/get/52108549155e1f216ce3110ab5968ac4/50401-jalinuxded_1.011.zip && \
  unzip /tmp/jedi_academy.zip -d /tmp/jedi_academy/ && \
  mv /tmp/jedi_academy/jampgamei386.so /tmp/jampgamei386.so && \
  mv /tmp/jedi_academy/linuxjampded /usr/local/games/ja/linuxjampded && \
  chmod a+x /usr/local/games/ja/linuxjampded && \
  mv /tmp/jedi_academy/libcxa.so.1 /usr/lib/libcxa.so.1 && \
  chmod a+x /usr/lib/libcxa.so.1 && \
  mv /tmp/jedi_academy/server.cfg /tmp/server.cfg && \
  rm -f /tmp/jedi_academy.zip && \
  rm -rf /tmp/jedi_academy

VOLUME /files

WORKDIR /usr/local/games/ja/

ADD run.sh ./run.sh

RUN chmod a+x ./run.sh

CMD ./run.sh

