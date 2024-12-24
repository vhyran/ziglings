const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var array = try allocator.alloc(i32, 5);
    defer allocator.free(array);

    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    array[3] = 4;
    array[4] = 5;

    var index: usize = 0;
    for (array) |item| {
        std.debug.print("array[{}] = {}\n", .{ index, item });
        index += 1;
    }
}

test "dynamic array allocation and iteration" {
    const allocator = std.testing.allocator;

    var array = try allocator.alloc(i32, 5);
    defer allocator.free(array);

    array[0] = 10;
    array[1] = 20;
    array[2] = 30;
    array[3] = 40;
    array[4] = 50;

    try std.testing.expect(array[0] == 10);
    try std.testing.expect(array[1] == 20);
    try std.testing.expect(array[2] == 30);
    try std.testing.expect(array[3] == 40);
    try std.testing.expect(array[4] == 50);

    var index: usize = 0;
    for (array) |item| {
        const expected = (index + 1) * 10;
        try std.testing.expect(item == expected);
        index += 1;
    }
    try std.testing.expect(index == 5);
}
