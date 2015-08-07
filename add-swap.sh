#!/bin/bash

SIZE="2G"
FILEPATH="/swapfile"

# enable virtual memory $SIZE for a server
fallocate -l $SIZE $FILEPATH && chmod 600 $FILEPATH && mkswap $FILEPATH && swapon $FILEPATH
echo "$FILEPATH   none    swap    sw    0   0" >> /etc/fstab