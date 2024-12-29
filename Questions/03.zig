const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Eliuds Eggs\n", .{});
    try stdout.print("eggCount(0b101001) = {}\n", .{eggCount(0b101001)});
}

// TODO: Eliuds Eggs
fn eggCount(number: usize) usize {
    var count: usize = 0;
    var tmp: usize = number;
    while (tmp != 0) {
        count += tmp & 1;
        tmp >>= 1;
    }
    return count;
}
