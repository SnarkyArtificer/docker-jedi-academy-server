# Jedi Academy Server

## Overview
This container runs v1.011 of the [Jedi Academy](https://en.wikipedia.org/wiki/Star_Wars_Jedi_Knight:_Jedi_Academy) Linux Server in Debian.

Since this game is basically unsupported (defunct companies tend to have issues doing that), and the game does not properly run on many modern linux systems, I have taken an effective snapshot of a configuration which ran the server well for me.

## Running the app

This guide assumes you understand basic Docker principles

1. Please mount the following game files in the /files directory:
  * assets0.pk3
  * assets1.pk3
  * assets2.pk3
  * any other pk3 files you want loaded (usually only if modding)
2. Networking
  * Open the following port ranges on the host or server
    * TCP 29070-29081
  * If you are having issues, throw the container in host mode
3. Mount custom config
  * mount server.cfg insode /usr/local/games/ja/base/
4. Once the container is running, connect by host IP

## Possible Future plans
Officially support any mods that need other config (likely already possible with correct file mounting)

## Known issues
Lightsabers will sometimes have rainbow colored shadows for a currently unknown reason.  Does not functionally change the game, just looks stupid.  A restart of the container often fixes this.

## Links

Github Repository: https://github.com/SnarkyArtificer/docker-jedi-academy-server
Docker repository: https://hub.docker.com/r/snarkyartificer/jedi-academy-server
