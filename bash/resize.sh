#!/bin/bash
used=$(df -hl / | awk 'NR == 2{print $5+0}')
echo "Used space: " ${used}
if [ "$used" -gt 85 ]
then
    echo "should resize"
    #Stop Services
    /DietPi/dietpi/dietpi-services stop
    #Resize partition
    cat << _EOF_ | fdisk /dev/mmcblk0
    p
    d
    2
    n
    p
    2
    $(parted /dev/mmcblk0 -ms unit s p | grep ':ext4::;' | sed 's/:/ /g' | sed 's/s//g' | awk '{ print $2 }')

    p
    w
_EOF_

    /DietPi/dietpi/dietpi-services stop

    # Resize Filesystem to new partition size
    resize2fs /dev/mmcblk0p2

    # Start services
    /DietPi/dietpi/dietpi-services start
else
    echo "should not resize"
    exit 0
fi
