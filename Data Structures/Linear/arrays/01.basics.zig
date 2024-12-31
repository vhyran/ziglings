const std = @import("std");

pub fn main() !void {
    const one_d = [_]u8{ 1, 2, 3, 4, 5, 6 };
    for (one_d) |i| {
        std.debug.print("{}", .{one_d[i]});
    }
}
