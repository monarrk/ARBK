if grub-file --is-x86-multiboot arbk.bin; then
	echo multiboot confirmed
else
	printf "the file is not multiboot, stopping\n"
	exit 1
fi

printf "Building..."
zig build-exe arbk.zig -target i386-freestanding --linker-script linker.ld --name arbk.bin || exit 1
printf "OK\n"

printf "Setting up directory..."
mkdir -p iso/boot/grub
cp arbk.bin iso/boot/arbk.bin
cp grub.cfg iso/boot/grub/grub.cfg
printf "OK\n"

printf "Making ISO (find a log in build.log)..."
grub-mkrescue iso -o arbk.iso &> build.log || exit 1
printf "OK\n"

exit 0
