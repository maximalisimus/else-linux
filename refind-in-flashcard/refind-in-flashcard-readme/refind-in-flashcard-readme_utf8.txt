
1) Flash Card mkdir -p EFI\boot.

2) unzip refind-bin-0.10.4.zip or refind-cd-0.10.4.zip in "refind" to Flash Card - EFI\boot.

3) rename:
	refind_aa64.efi -> bootaa64.efi
	refind_x64.efi -> bootx64.efi
	refind_ia32.efi -> bootia32.efi
	refind.conf-sample -> refind.conf

4) For EFI Shell -> unzip files on refind-cd-0.10.4.zip

Test rEFInd in Qemu.


