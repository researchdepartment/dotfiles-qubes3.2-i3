#!/usr/bin/env bash
vms=(uusx-vm) # Add VMs to shut down here
for vm in "${vms[@]}"
do
	echo "shutting down $vm"
	qvm-shutdown --wait $vm
	echo "$vm has been shut down"
	echo "unmounting $vm"
	sudo umount /var/lib/qubes/appvms/$vm
	sudo cryptsetup luksClose enc-$vm
	echo "$vm terminated and unmounted."
done
