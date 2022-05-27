

menuentry "Windows 7 Ultimate SP1" {
	set root=(hd0,msdos4)
	ntldr /bootmgr
}


menuentry "Windows 7 Ultimate SP1 (EFI)" {
	set root=hdX,Y
	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
	# boot
}

menuentry "Windows 7 Ultimate SP1" {
	set root=hdX,Y
	ntldr /bootmgr
}


	set vhd=/vhd/Ubuntu.vhd
	set vdhost
	search --no-floppy -s root -f $vhd
	loopback lp0 $vhd tdisk=VHD
	linux   (lp0,1)/vmlinuz root=/dev/vdhost/Partition1 vdisk=$vhd host=/dev/sda1 quiet splash
	initrd  (lp0,1)/initrd.img


menuentry "GPT-vhd-to-RAM" {
	insmod part_msdos
	insmod ntfs
	insmod chain
	set vhd=/vhd-to-ram-3.0gb.vhd
	set vhd=/GPT-vhd-to-RAM.vhd
	search --no-floppy --file  --set=root ${vhd}
	map --mem --type=hd ${vhd} gd
	ls (gd,2)/
	sleep -i -v 5
	chainloader (gd,2)/EFI/Boot/bootx64.efi
	boot
}



menuentry "Windows 7" {
	insmod ntfs
	set root=(hd0,1)
	drivemap -s (hd0) ($root)
	ntldr /bootmgr
	#or chainloader +1
}


menuentry "Windows 10" {
	insmod part_gpt
	insmod chain
	set root='(hd0,msdos2)'
	chainloader +1
}

if [ "${grub_platform}" == "pc" ]; then
	menuentry "Microsoft Windows Vista/7/8/8.1/10 BIOS/MBR" {
		insmod part_msdos
		insmod ntfs
		insmod search_fs_uuid
		insmod ntldr

		search --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 XXXXXXXXXXXXXXXX
		ntldr /bootmgr
	}
fi


insmod ntfs
insmod ntldr
insmod part_msdos
insmod ntfs
loopback loop (hd0,1)/test.vhd tdisk=VHD
ls (loop,msdos1)/






menuentry "VHD Ubuntu, Linux 2.6.31-14-generic" {
	insmod vhd
	vhd vhd0 (hd0,1)/ubuntu-910/ubuntu-910-desktop-i386.vhd --partitions
	linux (vhd0,1)/boot/vmlinuz-2.6.31-14-generic root=/dev/sda1 vloop=/ubuntu-910/ubuntu-910-desktop-i386.vhd quiet splash
	# root=/dev/vhdhost/Partition1 
	initrd (vhd0,1)/boot/initrd.img-2.6.31-14-generic-vboot
}


menuentry " Boot /ubuntu/disks/root.disk  root=UUID" {
	loopback loop0 /ubuntu/disks/root.disk
	set root=(loop0)
	search --set=diskroot -f -n /ubuntu/disks/root.disk
	probe --set=diskuuid -u $diskroot
	linux /vmlinuz root=UUID=$diskuuid loop=/ubuntu/disks/root.disk preseed/file=/ubuntu/install/preseed.cfg wubi-diskimage ro quiet splash
	initrd /initrd.img
}




