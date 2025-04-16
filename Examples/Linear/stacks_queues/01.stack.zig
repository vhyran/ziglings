const std = @import("std");

const Stack = struct {
    items: []i32,
    top: usize,
    capacity: usize,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator, capacity: usize) !Stack {
        const items = try allocator.alloc(i32, capacity);
        return Stack{
            .items = items,
            .top = 0,
            .capacity = capacity,
            .allocator = allocator,
        };
    }

    fn deinit(self: *Stack) void {
        self.allocator.free(self.items);
    }

    fn push(self: *Stack, value: i32) !void {
        if (self.top >= self.capacity) {
            return error.StackOverflow;
        }
        self.items[self.top] = value;
        self.top += 1;
    }

    fn pop(self: *Stack) !i32 {
        if (self.top == 0) {
            return error.StackUnderflow;
        }
        self.top -= 1;
        return self.items[self.top];
    }

    fn print(self: *Stack, writer: anytype) !void {
        try writer.print("Stack: ", .{});
        var i: usize = 0;
        while (i < self.top) : (i += 1) {
            try writer.print("{d} ", .{self.items[i]});
        }
        try writer.print("\n", .{});
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    var stack = try Stack.init(allocator, 5);
    defer stack.deinit();

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);
    try stack.print(stdout);

    const popped = try stack.pop();
    try stdout.print("Popped: {d}\n", .{popped});
    try stack.print(stdout);
}
