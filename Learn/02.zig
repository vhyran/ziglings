const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});
    try stdout.print("1997 is leap year: {s}\n", .{run(1997)});
    try stdout.print("2000 is leap year: {s}\n", .{run(2000)});
    try stdout.print("2004 is leap year: {s}\n", .{run(2004)});
    try stdout.print("1900 is leap year: {s}\n", .{run(1900)});
}

fn run(year: u32) []const u8 {
    const ans = is_leap_year(year);
    if (ans) {
        return "Leap year\n";
    } else {
        return "Not leap year\n";
    }
}
// TODO: IS LEEP YEAR
fn is_leap_year(year: u32) bool {
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0);
}
