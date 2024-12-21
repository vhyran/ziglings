const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var array = try allocator.alloc(i32, 5);
    defer allocator.free(array);

    // Initialize array
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;
    array[3] = 4;
    array[4] = 5;

    // Print array elements
    var index: usize = 0;
    for (array) |item| {
        std.debug.print("array[{}] = {}\n", .{ index, item });
        index += 1;
    }
}
