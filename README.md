
[//]: # (This file is generated, modify doc/readme.adoc and regenerate it with 'make update-doc')

![<https://github.com/jfgiraud/rearrange/actions>](https://img.shields.io/github/actions/workflow/status/jfgiraud/rearrange/main.yml?label=CI)

Description
===========

**rearr** is a small utility to rearrange sections in each line of
files.

It can remove and duplicate sections and also change the order of
sections.

Installation
============

The destination directory will contain 3 sub-directories: `bin`, `share`
and `man`.

**Using git repo.**

    $ git clone https://github.com/jfgiraud/rearrange.git
    $ cd rearrange
    $ sudo make install DESTDIR=/usr/local

**Using latest tarball release.**

    $ curl -s -L https://api.github.com/repos/jfgiraud/rearrange/releases/latest | grep browser_download_url | cut -d':' -f2- | tr -d ' ",' | xargs wget -O rearrange.tgz
    $ sudo tar zxvf rearrange.tgz -C /usr/local

Usage
=====

**Use man.**

    $ man rearr

**Use option.**

    $ rearr -h

Examples
========

**Display fields `4`, `1 to 3` and the `2 lasts` of `/etc/passwd`
changing the output separator to `;`..**

    $ rearr -f4,1:3,-2: -d: -o';' /etc/passwd | head
    0;root;x;0;/root;/bin/bash
    1;daemon;x;1;/usr/sbin;/usr/sbin/nologin
    2;bin;x;2;/bin;/usr/sbin/nologin
    3;sys;x;3;/dev;/usr/sbin/nologin
    65534;sync;x;4;/bin;/bin/sync
    60;games;x;5;/usr/games;/usr/sbin/nologin
    12;man;x;6;/var/cache/man;/usr/sbin/nologin
    7;lp;x;7;/var/spool/lpd;/usr/sbin/nologin
    8;mail;x;8;/var/mail;/usr/sbin/nologin
    9;news;x;9;/var/spool/news;/usr/sbin/nologin

**Display fields `1` to `last` (step by 2)..**

    $ head /etc/passwd | rearr -d':' -f 1::2
    root:0:root:/bin/bash
    daemon:1:daemon:/usr/sbin/nologin
    bin:2:bin:/usr/sbin/nologin
    sys:3:sys:/usr/sbin/nologin
    sync:4:sync:/bin/sync
    games:5:games:/usr/sbin/nologin
    man:6:man:/usr/sbin/nologin
    lp:7:lp:/usr/sbin/nologin
    mail:8:mail:/usr/sbin/nologin
    news:9:news:/usr/sbin/nologin

**Reverse columns..**

    $ head /etc/passwd | rearr -d':' -f -1:1:-1
    /bin/bash:/root:root:0:0:x:root
    /usr/sbin/nologin:/usr/sbin:daemon:1:1:x:daemon
    /usr/sbin/nologin:/bin:bin:2:2:x:bin
    /usr/sbin/nologin:/dev:sys:3:3:x:sys
    /bin/sync:/bin:sync:65534:4:x:sync
    /usr/sbin/nologin:/usr/games:games:60:5:x:games
    /usr/sbin/nologin:/var/cache/man:man:12:6:x:man
    /usr/sbin/nologin:/var/spool/lpd:lp:7:7:x:lp
    /usr/sbin/nologin:/var/mail:mail:8:8:x:mail
    /usr/sbin/nologin:/var/spool/news:news:9:9:x:news
