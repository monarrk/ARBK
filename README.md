# ARBK

A Really Bad Kernel

## Building

```
zig build-exe arbk.zig -target i386-freestanding --linker-script linker.ld
```

## Testing with qemu

```
qemu-system-i386 -kernel arbk
```
