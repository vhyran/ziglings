const std = @import("std");

const Queue = struct {
    items: []i32,
    front: usize,
    rear: usize,
    capacity: usize,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator, capacity: usize) !Queue {
        const items = try allocator.alloc(i32, capacity);
        return Queue{
            .items = items,
            .front = 0,
            .rear = 0,
            .capacity = capacity,
            .allocator = allocator,
        };
    }

    fn deinit(self: *Queue) void {
        self.allocator.free(self.items);
    }

    fn enqueue(self: *Queue, value: i32) !void {
        if (self.rear >= self.capacity) {
            return error.QueueFull;
        }
        self.items[self.rear] = value;
        self.rear += 1;
    }

    fn dequeue(self: *Queue) !i32 {
        if (self.front >= self.rear) {
            return error.QueueEmpty;
        }
        const value = self.items[self.front];
        self.front += 1;
        return value;
    }

    fn print(self: *Queue, writer: anytype) !void {
        try writer.print("Queue: ", .{});
        var i: usize = self.front;
        while (i < self.rear) : (i += 1) {
            try writer.print("{d} ", .{self.items[i]});
        }
        try writer.print("\n", .{});
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    var queue = try Queue.init(allocator, 5);
    defer queue.deinit();

    try queue.enqueue(1);
    try queue.enqueue(2);
    try queue.enqueue(3);
    try queue.print(stdout);

    const dequeued = try queue.dequeue();
    try stdout.print("Dequeued: {d}\n", .{dequeued});
    try queue.print(stdout);
}
