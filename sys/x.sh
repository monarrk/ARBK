KEEP=NO

case $1 in
	# clean built files
	"clean")
		rm -rf iso *.o *.bin *.log *.iso
		exit 0
		;;
	# run the binary file without grub
	"run-bin")
		command -v qemu-system-x86_64 || printf "You need qemu\n"
		qemu-system-x86_64 -kernel arbk.bin
		exit 0
		;;
	# run the CDROM with grub
	"run")
		qemu-system-x86_64 -cdrom arbk.iso
		exit 0
		;;
	# keep files
	"keep")
		KEEP=YES
		;;
esac

printf "Building..."
zig build-exe src/arbk.zig -target i386-freestanding --linker-script sys/linker.ld --name ./arbk.bin || exit 1
printf "OK\n"

printf "Checking for multiboot..."
grub-file --is-x86-multiboot arbk.bin || exit 1
printf "OK\n"

if [[ -d iso ]]; then
	printf "Removing directory..."
	rm -rf iso
	printf "OK\n"
fi

printf "Setting up directory..."
mkdir -p iso/boot/grub
mkdir -p iso/usr/src
mkdir iso/usr/include
cp -r src iso/usr/src/kernel
cp arbk.bin iso/boot/arbk.bin
cp sys/grub.cfg iso/boot/grub/grub.cfg
printf "OK\n"

printf "Making ISO..."
grub-mkrescue iso -o arbk.iso --verbose &> build.log || exit 1
printf "OK\n"

# remove useless files if "keep" is not passed
case $KEEP in
	"YES")
		exit 0
		;;
	"NO")
		printf "Removing trash files and logs (to keep, pass 'keep')..."
		rm *.log *.o
		printf "OK\n"
		;;
esac

printf "Done! To use, run 'x.sh run' or 'x.sh run-bin'\n"
