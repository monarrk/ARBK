pub fn halt() void {
    // use assembly to halt the cpu
    asm volatile (
        \\hlt
    );
}
