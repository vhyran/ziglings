const std = @import("std");

const Node = struct {
    data: i32,
    prev: ?*Node,
    next: ?*Node,
};

const DoublyLinkedList = struct {
    head: ?*Node,
    allocator: std.mem.Allocator,

    const DeleteError = error{
        EmptyList,
        ValueNotFound,
    };

    fn init(allocator: std.mem.Allocator) DoublyLinkedList {
        return DoublyLinkedList{ .head = null, .allocator = allocator };
    }

    fn deinit(self: *DoublyLinkedList) void {
        var current = self.head;
        while (current) |node| {
            current = node.next;
            self.allocator.destroy(node);
        }
        self.head = null;
    }

    fn append(self: *DoublyLinkedList, value: i32) !void {
        const new_node = try self.allocator.create(Node);
        new_node.* = .{ .data = value, .prev = null, .next = null };

        if (self.head == null) {
            self.head = new_node;
            return;
        }

        var current = self.head;
        while (current.?.next) |next| {
            current = next;
        }
        current.?.next = new_node;
        new_node.prev = current;
    }

    fn delete(self: *DoublyLinkedList, value: i32) DeleteError!void {
        if (self.head == null) {
            return error.EmptyList;
        }

        var current = self.head;
        while (current) |node| {
            if (node.data == value) {
                if (node.prev) |prev| {
                    prev.next = node.next;
                } else {
                    self.head = node.next;
                }
                if (node.next) |next| {
                    next.prev = node.prev;
                }
                self.allocator.destroy(node);
                return;
            }
            current = node.next;
        }

        return error.ValueNotFound;
    }

    fn print(self: *DoublyLinkedList, writer: anytype) !void {
        try writer.print("DoublyLinkedList: ", .{});
        var current = self.head;
        while (current) |node| {
            try writer.print("{d} <-> ", .{node.data});
            current = node.next;
        }
        try writer.print("null\n", .{});
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    var list = DoublyLinkedList.init(allocator);
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
