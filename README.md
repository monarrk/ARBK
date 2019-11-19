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
