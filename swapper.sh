#!/bin/bash

## Usage: ./swapper.sh <filename> <size>

SWAP_FILENAME="/swapfile"
SWAP_SIZE=4G

if [[ -n $1 ]]; then
	SWAP_FILENAME=$1
fi

if [[ -n $2 ]]; then
	SWAP_SIZE=$2
fi

echo "Adding a '$SWAP_FILENAME' of size; $SWAP_SIZE"

fallocate -l $SWAP_SIZE $SWAP_FILENAME
chmod 600 $SWAP_FILENAME
mkswap $SWAP_FILENAME
swapon $SWAP_FILENAME

# make this survice reboot
echo "$SWAP_FILENAME   none    swap    sw    0   0" >> /etc/fstab