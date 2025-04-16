const std = @import("std");

const Node = struct {
    data: i32,
    next: ?*Node,
};

const SinglyLinkedList = struct {
    head: ?*Node,
    allocator: std.mem.Allocator,

    const DeleteError = error{
        EmptyList,
        ValueNotFound,
    };

    fn init(allocator: std.mem.Allocator) SinglyLinkedList {
        return SinglyLinkedList{ .head = null, .allocator = allocator };
    }

    fn deinit(self: *SinglyLinkedList) void {
        var current = self.head;
        while (current) |node| {
            current = node.next;
            self.allocator.destroy(node);
        }
        self.head = null;
    }

    fn append(self: *SinglyLinkedList, value: i32) !void {
        const new_node = try self.allocator.create(Node);
        new_node.* = .{ .data = value, .next = null };

        if (self.head == null) {
            self.head = new_node;
            return;
        }

        var current = self.head;
        while (current.?.next) |next| {
            current = next;
        }
        current.?.next = new_node;
    }

    fn delete(self: *SinglyLinkedList, value: i32) DeleteError!void {
        if (self.head == null) {
            return error.EmptyList;
        }

        if (self.head.?.data == value) {
            const temp = self.head;
            self.head = self.head.?.next;
            self.allocator.destroy(temp.?);
            return;
        }

        var current = self.head;
        while (current.?.next) |next| {
            if (next.data == value) {
                current.?.next = next.next;
                self.allocator.destroy(next);
                return;
            }
            current = next;
        }

        return error.ValueNotFound;
    }

    fn print(self: *SinglyLinkedList, writer: anytype) !void {
        try writer.print("SinglyLinkedList: ", .{});
        var current = self.head;
        while (current) |node| {
            try writer.print("{d} -> ", .{node.data});
            current = node.next;
        }
        try writer.print("null\n", .{});
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    var list = SinglyLinkedList.init(allocator);
    defer list.deinit();

    try list.append(1);
    try list.append(2);
    try list.append(3);
    try list.print(stdout);

    list.delete(2) catch |err| {
        try stdout.print("Error deleting 2: {}\n", .{err});
        return;
    };
    try stdout.print("After deleting 2: ", .{});
    try list.print(stdout);

    // Demonstrate error handling for value not found
    list.delete(10) catch |err| {
        try stdout.print("Error deleting 10: {}\n", .{err});
        return;
    };
}
