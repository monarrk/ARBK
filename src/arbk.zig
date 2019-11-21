const builtin = @import("builtin");
const vga = @import("lib/vga.zig");
const util = @import("lib/util.zig");

const MultiBoot = packed struct {
    magic: i32,
    flags: i32,
    checksum: i32,
};

const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const MAGIC = 0x1BADB002;
const FLAGS = ALIGN | MEMINFO;

export var multiboot align(4) linksection(".multiboot") = MultiBoot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

export var stack_bytes: [16 * 1024]u8 align(16) linksection(".bss") = undefined;
const stack_bytes_slice = stack_bytes[0..];

export nakedcc fn _start() void {
    @newStackCall(stack_bytes_slice, kmain);
    util.halt();
}

fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) void {
    @setCold(true);
    vga.terminal.write("KERNEL PANIC: ");
    vga.terminal.write(msg);
    util.halt();
}

//
// MAIN
//
fn kmain() void {
    // Welcome with some fancy colors
    vga.terminal.initialize();
    vga.terminal.write("Welcome!\n");
    // write with color escapes. See lib.vga.terminal
    vga.terminal.writef("Booted%[1 ARBK%[7 v0.0.1");
}
