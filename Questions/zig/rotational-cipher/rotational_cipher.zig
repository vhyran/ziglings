const mem = @import("std").mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    var result = try allocator.alloc(u8, text.len);
    for (text, 0..) |c, i| {
        result[i] = switch (c) {
            'A'...'Z' => (c - 65 + shiftKey) % 26 + 65,
            'a'...'z' => (c - 97 + shiftKey) % 26 + 97,
            else => c,
        };
    }
    return result;
}
