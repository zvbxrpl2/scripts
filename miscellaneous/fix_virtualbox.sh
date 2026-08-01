#!/bin/sh


# SEE https://forums.virtualbox.org/viewtopic.php?f=1&t=106582&sid=8d10e31e06d4f5101424c02d689033a3

find /lib/modules -name "vboxdrv*"
modinfo /lib/modules/5.15.0-47-generic/misc/vboxdrv.ko

rmmod vboxnetflt
rmmod vboxnetadp
rmmod vboxdrv

insmod /lib/modules/5.15.0-47-generic/misc/vboxdrv.ko

modprobe vboxnetadp
modprobe vboxnetflt


