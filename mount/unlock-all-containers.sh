#!/usr/bin/env bash
vms=(uusx-vm) # Add VMs to unlock here
for vm in "${vms[@]}"
do
	file=/var/lib/qubes/appvms/$vm.img
	if [ -f $file ]; then
		echo "opening $vm"
		sudo cryptsetup luksOpen /var/lib/qubes/appvms/$vm.img enc-$vm
		echo "mounting $vm"
		sudo mount /dev/mapper/enc-$vm /var/lib/qubes/appvms/$vm
		echo "$vm has been mounted"
	else
		echo "$vm doesn't exist"
	fi
done
