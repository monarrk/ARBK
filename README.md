# ARBK

A Really Bad Kernel

## Building

To build, you need grub, zig, and a UNIX system.

You can use `sys/x.sh` to build. This will create a binary kernel file and a cdrom packaged with GRUB.

## Testing with qemu

```
qemu-system-i386 -kernel arbk.bin

# OR

qemu-system-i386 -cdrom arbk.iso
```

## Directory setup
```
/
--README.md	README, duh

--sys/
----x.sh	utilities like build, clean, and run
----linker.ld	linker script
----grub.cfg	grub config file put in iso/boot/grub/grub.cfg

--src/
----arbk.zig	the main kernel file
----lib/
------stdio.zig	nothing, yet
------vga.zig	vga functions and constants
------util.zig	OS utility functions
```
