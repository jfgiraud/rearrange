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

**Display fields 4, 1 to 3 and the 2 lasts of `/etc/passwd` changing the
output separator to `;`..**

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
