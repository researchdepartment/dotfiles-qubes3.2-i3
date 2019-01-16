#!/usr/bin/env bash
if [ $# -eq 0 ]
then
	echo "usage: unlock-vm-container.sh vmname"
	exit
fi
vm=$1
file=/var/lib/qubes/appvms/$vm.img
if [ -f $file ]; then
	echo "opening $vm"
	sudo cryptsetup luksOpen $file enc-$vm
	echo "mounting $vm"
	sudo mount /dev/mapper/enc-$vm /var/lib/qubes/appvms/$vm
	echo "$vm has been mounted"
else
	echo "$vm doesn't exist"
fi
