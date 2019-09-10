# ARBK

A Really Bad Kernel

## Building

```
zig build-exe arbk.zig -target i386-freestanding --linker-script linker.ld --name arbk.bin
mkdir -p iso/boot/grub
cp arbk.bin iso/boot/arbk.bin
cp grub.cfg iso/boot/grub/grub.cfg
grub-mkrescue iso -o arbk.iso
```

## Testing with qemu

```
qemu-system-i386 -kernel arbk
```
