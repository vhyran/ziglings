const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // Dynamic One-Dimensional Array
    var one_d = std.ArrayList(u8).init(allocator);
    defer one_d.deinit();

    try one_d.append(1);
    try one_d.append(2);
    try one_d.append(3);

    std.debug.print("One-Dimensional Array:\n", .{});
    for (one_d.items) |value| {
        std.debug.print("{}\n", .{value});
    }

    // Dynamic Two-Dimensional Array
    var two_d = std.ArrayList(std.ArrayList(u8)).init(allocator);
    defer two_d.deinit();

    const static_two_d = [_][3]u8{
        [3]u8{1, 2, 3},
        [3]u8{4, 5, 6},
        [3]u8{7, 8, 9},
    };
    for (static_two_d) |row| {
        var dynamic_row = std.ArrayList(u8).init(allocator);

        // Append values to the dynamic row
        for (row) |value| {
            try dynamic_row.append(value);
        }
        
        // Move ownership of `dynamic_row` to `two_d`
        try two_d.append(dynamic_row);
    }

    std.debug.print("\nTwo-Dimensional Array:\n", .{});
    for (two_d.items) |row| {
        for (row.items) |value| {
            std.debug.print("{}\n", .{value});
        }
    }

    // Dynamic Three-Dimensional Array
    var three_d = std.ArrayList(std.ArrayList(std.ArrayList(u8))).init(allocator);
    defer three_d.deinit();

    const static_three_d = [_][2][2]u8{
        [2][2]u8{
            [2]u8{1, 2},
            [2]u8{3, 4},
        },
        [2][2]u8{
            [2]u8{5, 6},
            [2]u8{7, 8},
        },
    };
    for (static_three_d) |matrix| {
        var dynamic_matrix = std.ArrayList(std.ArrayList(u8)).init(allocator);

        for (matrix) |row| {
            var dynamic_row = std.ArrayList(u8).init(allocator);

            for (row) |value| {
                try dynamic_row.append(value);
            }

            try dynamic_matrix.append(dynamic_row);
        }

        try three_d.append(dynamic_matrix);
    }

    std.debug.print("\nThree-Dimensional Array:\n", .{});
    for (three_d.items) |matrix| {
        for (matrix.items) |row| {
            for (row.items) |value| {
                std.debug.print("{}\n", .{value});
            }
        }
    }
}
