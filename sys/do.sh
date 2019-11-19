case $1 in
	"clean")
		rm -rf iso *.o *.bin *.log *.iso
		exit 0
		;;
	"run-bin")
		command -v qemu-system-x86_64 || printf "You need qemu\n"
		qemu-system-x86_64 -kernel arbk.bin
		exit 0
		;;
	"run")
		qemu-system-x86_64 -cdrom arbk.iso
		exit 0
		;;
esac

printf "Building..."
zig build-exe kernel/arbk.zig -target i386-freestanding --linker-script sys/linker.ld --name ./arbk.bin || exit 1
printf "OK\n"

printf "Checking for multiboot..."
grub-file --is-x86-multiboot arbk.bin || exit 1
printf "OK\n"

printf "Setting up directory..."
mkdir -p iso/boot/grub
mkdir -p iso/usr/src
cp -r kernel iso/usr/src/kernel
cp arbk.bin iso/boot/arbk.bin
cp sys/grub.cfg iso/boot/grub/grub.cfg
printf "OK\n"

printf "Making ISO (find a log in build.log)..."
grub-mkrescue iso -o arbk.iso --verbose &> build.log || exit 1
printf "OK\n"

exit 0
