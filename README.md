# Server Setup

Here's a collection of scripts for common operations I perform during provisioning and setup of servers. 

I use Ubuntu server most of the time. I will indicate in areas where the OS isn't Ubuntu

## Add a Swap file

By default, this creates a `4G` `/swapfile`. You can specify the size of the swap file. 

** Usage **

```
bash swapper.sh <filename> <size>
```

** Example **
```
sudo bash swapper.sh /swapfile 2G
```

More information https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04