NAME
====

rearr - Rearrange sections in each lines of files

SYNOPSIS
========

**rearr** \[*OPTION*\] \[*FILE*\]

DESCRIPTION
===========

**rearr** is a small utility to rearrange sections in each line of
files.

It can remove and duplicate sections and also change the order of
sections.

With no FILE, or when FILE is `-`, read standard input.

OPTIONS
=======

**-h**  
Display help.

**-v**  
Display version.

**-d** *DELIM*  
Use DELIM instead of TAB for field delimiter. Do not define when
selecting characters with option **-c**;

**-o** *DELIM*  
Use DELIM as the output delimiter the default is to use the input
delimiter.

**-f** *LIST*  
Select only these fields; also print any line that contains no delimiter
character, unless the -s option is specified. Each item of the list is a
number (=1 for the first, -1 for the last) or a range (start:end(:step)
where start/end values are includes and the step increment optional).

**-c** *LIST*  
select only these characters. Each item of the list is a number (=1 for
the first, -1 for the last) or a range (start:end(:step) where start/end
values are includes and the step increment optional)

**-s**  
do not print lines not containing delimiters

EXAMPLES
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
