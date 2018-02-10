#!/bin/bash

function copy_base_file {
  FILENAME="$1"
  echo "Checking for existing $FILENAME"
  if ! [ -e "/usr/local/games/ja/base/$FILENAME" ]; then
    echo "No $FILENAME found, creating default one"
    cp /tmp/$FILENAME /usr/local/games/ja/base/$FILENAME
  else
    echo "Found pre-existing $FILENAME"
  fi
}

copy_base_file jampgamei386.so
copy_base_file server.cfg

chmod a+rwx /usr/local/games/ja/base/jampgamei386.so
./linuxjampded +set net_port "29070" +exec server.cfg
