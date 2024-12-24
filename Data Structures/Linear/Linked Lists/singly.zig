const std = @import("std");

const Node = struct {
    value: i32,
    next: ?*Node,
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var head: ?*Node = null;
    head = try append(head, 10, &allocator);
    head = try append(head, 20, &allocator);
    head = try append(head, 30, &allocator);

    printList(head);
    freeList(head, &allocator);
}

pub fn append(head: ?*Node, value: i32, allocator: *const std.mem.Allocator) !?*Node {
    const new_node = try allocator.create(Node);
    new_node.* = Node{ .value = value, .next = null };
    if (head == null) {
        return new_node;
    }

    var current = head;
    while (current) |current_node| {
        if (current_node.next == null) {
            current_node.next = new_node;
            break;
        }
        current = current_node.next;
    }
    return head;
}

pub fn freeList(head: ?*Node, allocator: *const std.mem.Allocator) void {
    var current = head;
    while (current) |node| {
        const next = node.next;
        allocator.destroy(node);
        current = next;
    }
}

pub fn printList(head: ?*Node) void {
    var current = head;
    while (current) |node| {
        std.debug.print("{} -> ", .{node.value});
        current = node.next;
    }
    std.debug.print("null\n", .{});
}
