type=post
author=Uli Heller
status=published
title=LXC: Alte Container starten nicht mehr
date=2017-01-30 10:00
comments=true
tags=lxc
~~~~~~

```
root@blacky:~# lxc-start -F -n dropzone
lxc-start: utils.c: safe_mount: 1746 Invalid argument \
- Failed to mount /sys/kernel/debug onto /usr/lib/x86_64-linux-gnu/lxc/sys/kernel/debug
init: Unable to create device: /dev/kmsg
 * Starting Mount filesystems on boot   ...done.
 * Stopping Send an event to indicate plymouth is up   ...done.
 * Starting Signal sysvinit that the rootfs is mounted   ...done.
 * Starting Populate /dev filesystem   ...done.
 * Starting Clean /tmp directory   ...done.
 * Starting Populate and link to /run filesystem   ...done.
 * Stopping Clean /tmp directory   ...done.
 * Stopping Populate and link to /run filesystem   ...done.
 * Starting Track if upstart is running in a container   ...done.
 * Starting load fallback graphics devices   ...done.
 * Starting workaround for missing events in container   ...done.
 * Stopping load fallback graphics devices   ...done.
 * Starting Initialize or finalize resolvconf   ...done.
 * Stopping workaround for missing events in container   ...done.
 * Starting userspace bootsplash   ...done.
 * Starting Send an event to indicate plymouth is up   ...done.
 * Starting configure network device security   ...done.
 * Stopping userspace bootsplash   ...done.
 * Stopping Send an event to indicate plymouth is up   ...done.
 * Starting Mount network filesystems   ...done.
 * Stopping Mount network filesystems   ...done.
 * Starting configure network device   ...done.
 * Starting Bridge socket events into upstart   ...done.
 * Stopping Populate /dev filesystem   ...done.
```
