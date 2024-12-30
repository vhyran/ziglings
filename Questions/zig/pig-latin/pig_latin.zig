const mem = @import("std").mem;

fn isVowel(c: u8) bool {
    return switch (c) {
        'a', 'e', 'i', 'o', 'u' => true,
        else => false,
    };
}

fn isSpecialBeginning(f: u8, l: u8) bool {
    return f == 'x' and l == 'f' or f == 'y' and l == 't';
}

pub fn translate(allocator: mem.Allocator, phrase: []const u8) mem.Allocator.Error![]u8 {
    var buffer: []u8 = allocator.alloc(u8, 0) catch unreachable;
    errdefer allocator.free(buffer);

    return buffer;
}
