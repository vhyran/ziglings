const std = @import("std");

pub fn main() !void {
    // One-Dimensional Array
    const one_d = [_]u8{ 1, 2, 3, 4, 5, 6 };
    std.debug.print("One-Dimensional Array:\n", .{});
    for (one_d) |value| {
        std.debug.print("{}\n", .{value});
    }

    // Two-Dimensional Array
    const two_d = [3][3]u8{ // Explicitly specify the dimensions
        [3]u8{ 1, 2, 3 },
        [3]u8{ 4, 5, 6 },
        [3]u8{ 7, 8, 9 },
    };
    std.debug.print("\nTwo-Dimensional Array:\n", .{});
    for (two_d) |row| {
        for (row) |value| {
            std.debug.print("{} ", .{value});
        }
        std.debug.print("\n", .{});
    }

    // Three-Dimensional Array
    const three_d = [2][2][2]u8{ // Explicitly specify the dimensions
        [2][2]u8{
            [2]u8{ 1, 2 },
            [2]u8{ 3, 4 },
        },
        [2][2]u8{
            [2]u8{ 5, 6 },
            [2]u8{ 7, 8 },
        },
    };
    std.debug.print("\nThree-Dimensional Array:\n", .{});
    for (three_d) |matrix| {
        for (matrix) |row| {
            for (row) |value| {
                std.debug.print("{} ", .{value});
            }
            std.debug.print("\n", .{});
        }
        std.debug.print("\n", .{});
    }
}
