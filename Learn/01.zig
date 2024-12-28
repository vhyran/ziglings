const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const arr = [_]i32{ 1, 2, 3, 4, 5 };
    const str = "world";
    try stdout.print("Hello, {s}!\n", .{str});
    try stdout.print("3 * 4 = {}\n", .{multiply(3, 4)});
    try stdout.print("Factorial of 5 is {}\n", .{factorial(5)});
    try stdout.print("Sum of [1, 2, 3, 4, 5] is {}\n", .{slice_sum(&arr)});
}

fn multiply(a: i32, b: i32) i32 {
    return a * b;
}

fn factorial(n: i32) i32 {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

fn slice_sum(arr: []const i32) i32 {
    var sum: i32 = 0;
    for (arr) |i| {
        sum += i;
    }
    return sum;
}
