const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, zig!\n", .{});
}

fn squareOfSum(number: usize) usize {
    var sum: usize = 0;
    var tmp = number;
    while (tmp != 0) {
        sum += tmp;
        tmp -= 1;
    }
    return sum;
}

fn sumOfSquares(number: usize) usize {
    var sum: usize = 0;
    var tmp = number;
    while (tmp != 0) {
        sum += tmp * tmp;
        tmp -= 1;
    }
    return sum;
}

fn differenceOfSquar(number: usize) usize {
    var sum: usize = 0;
    var tmp = number;
    while (tmp != 0) {
        sum += tmp;
        tmp -= 1;
    }
    return sum;
}
